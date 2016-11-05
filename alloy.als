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
	car : lone Car
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
	user : lone User
} {
	capacity > 0 and capacity <= 4
	state = AVAILABLE or state = RESERVED <=> battery = FULL 
	#user = 1 <=> (state = RESERVED or state = WORKING)
	#user = 0 <=> (state = AVAILABLE or state = NOTAVAILABLE)
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


// facts
fact NoSameCredential {
	no disjoint u1,u2 : User | u1.credential = u2.credential
}

fact NoSamePaymentInfo {
	no disjoint u1,u2 : User | u1.paymentInfo & u2.paymentInfo != none
}

fact OneUserOneCar {
	no disjoint u1,u2 : User | u1.car in u2.car 
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
pred example {
	
}

run example  




