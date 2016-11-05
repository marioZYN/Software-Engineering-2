open util/boolean

sig Float { }
sig Astring { }

sig Credential {
	email : one Astring,
	password : one Astring,
	username : one Astring,
	drivingLicenseNo : one Astring,
}
sig PaymentInfo {
	name : one Astring,
	surname : one Astring, 
	cardType : one Astring,
	cardNo : one Astring,
	cellphoneNo : one Astring,
	taxCode : one Astring
} {
	all p : PaymentInfo | p in User.paymentInfo
}

sig User {
	credential : one Credential,
	paymentInfo : set PaymentInfo,

} {
	paymentInfo != none
}

sig Position {
	latitude : one Float,
	longitude : one Float
} {
	all p : Position | p in Area.points
}

//Area should be a range, but for simplicity we consider only a set of points

abstract sig Area {
	points : set Position
}
sig SafeArea extends Area { }
sig UnSafeArea extends Area { }
sig ChargeArea in SafeArea { }

abstract sig CarState { }
one sig AVAILABLE extends CarState { }
one sig RESERVED extends CarState { }
one sig WORKING extends CarState { }
one sig NOTAVAILABLE extends CarState { }

abstract sig BatteryState { }
one sig FULL extends BatteryState { }
one sig MEDIUM extends BatteryState { }
one sig LOW extends BatteryState { } 

sig Car {
	plate : one Astring,
	capacity : one Int,
	state : one CarState,
	battery : one BatteryState,
	currentPosition : one Position,
} {
	capacity > 0 and capacity <= 4
	state = AVAILABLE or state = RESERVED <=> battery = FULL 
	state = NOTAVAILABLE <=> (currentPosition in UnSafeArea.points or battery != FULL)
	currentPosition in SafeArea.points <=> state = AVAILABLE or state = RESERVED
	state = RESERVED <=> this in Reservation.car
}

sig Reservation {
	user : one User,
	car : one Car,
} {
	car.state = RESERVED
}

one sig System {
	users : set User,
	cars : set Car,
	safeAreas : set SafeArea
} {
	all u : User | u in users
	all c : Car | c in cars
	all sa : SafeArea | sa in safeAreas 
}

sig Ride {
	user : one User,
	car : one Car,
	number : one Int,
	currentCharge : one Float,
	moneySaveOption : one Bool,
	discountDest : lone Position,
	discount : one Discount
} {
	number >=1
	car.state = WORKING or car.state = NOTAVAILABLE
	moneySaveOption = True <=> #discountDest = 1
}

abstract sig Discount { }
one sig NONE extends Discount { }
one sig MinusTen extends Discount { }
one sig MinusTwenty extends Discount { }
one sig MinusThirty extends Discount { }
one sig PlusThirty extends Discount { }

// -----------FACTS-------------
fact NoSameCredential {
	no disjoint u1,u2 : User | u1.credential = u2.credential
}

fact NoSamePaymentInfo {
	no disjoint u1,u2 : User | u1.paymentInfo & u2.paymentInfo != none
}

fact NoSameArea {
	no disjoint a1,a2 : Area | a1.points & a2.points != none
}

fact UserCarRelation {
	all u : User | u.car.user = u
}

fact NoCarAtSamePlace {
	no disjoint c1,c2 : Car | c1.currentPosition = c2.currentPosition
}	

fact NoSameReservationUserAndCar {
	no disjoint r1,r2 : Reservation | r1.user = r2.user
	no disjoint r1,r2 : Reservation | r1.car = r2.car
}

pred example {
	
}

run example  


//------------ASSERTIONS----------------

assert AvailableCarPosition {
	no c : Car | c.state = AVAILABLE and c.currentPosition in UnSafeArea.points
}
check AvailableCarPosition

assert ReservedCarPosition {
	no c : Car | c.state = RESERVED and c.currentPosition in UnSafeArea.points
}
check ReservedCarPosition





