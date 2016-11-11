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
sig Station extends SafeArea { }
sig NonStation extends SafeArea { }

abstract sig CarState { }
one sig AVAILABLE extends CarState { }
one sig RESERVED extends CarState { }
one sig WORKING extends CarState { }
one sig CHARGING extends CarState { }
one sig UNCHARGING extends CarState { }

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
	state = AVAILABLE <=> battery = FULL 
    state = RESERVED <=> battery = FULL
	state = AVAILABLE implies currentPosition in Station.points
	state = RESERVED implies currentPosition in Station.points
	state = CHARGING implies currentPosition in Station.points
	state = UNCHARGING implies currentPosition in NonStation.points
	state = WORKING implies this in Ride.car
	state = CHARGING implies this in Ride.car
	state = UNCHARGING implies this in Ride.car
	state = RESERVED implies this in Reservation.car
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
	numberOfPassenger : one Int,
	currentCharge : one Float,
	moneySaveOption : one Bool,
	discountDest : lone Position,
	completed : one Bool,
	dp : one DiscountAndPunish
} {
	car.state = WORKING or car.state = CHARGING or car.state = UNCHARGING
	car.state = WORKING implies completed = False 
	car.state != WORKING implies completed = True 
	moneySaveOption = True <=> #discountDest = 1
	discountDest in Station.points
	dp.batteryDiscount = True implies completed = True
	dp.rechargeDiscount = True implies completed = True
	dp.distancePunishment = True implies completed = True
	dp.lowBatteryPunishment = True implies completed = True
}

sig DiscountAndPunish { 
	passengerDiscount : one Bool,
	batteryDiscount : one Bool,
	rechargeDiscount : one Bool,
	distancePunishment : one Bool,
	lowBatteryPunishment : one Bool	
}

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

fact NoCarAtSamePlace {
	no disjoint c1,c2 : Car | c1.currentPosition = c2.currentPosition
}	

fact NoSameReservationUserAndCar {
	no disjoint r1,r2 : Reservation | r1.user = r2.user
	no disjoint r1,r2 : Reservation | r1.car = r2.car
}

fact DiscountAndPunishmentCondition {
	no r : Ride | r.dp.passengerDiscount = True and r.numberOfPassenger <= 2
	no r : Ride | r.dp.batteryDiscount = True and r.car.battery != MEDIUM
	no r : Ride | r.dp.rechargeDiscount = True and r.car.currentPosition not in Station.points
	no r : Ride | r.dp.rechargeDiscount = True and r.dp.distancePunishment = True
	no r : Ride | r.dp.distancePunishment = True and r.car.currentPosition in Station.points
	no r : Ride | r.dp.lowBatteryPunishment = True and r.car.battery != LOW
}

//There should be no intersection between {user,car} in Reservation and {user,car} in Ride
fact ReservationRideDistinction {
	all r1 : Reservation, r2 : Ride | r1.user != r2.user and r1.car != r2.car
}

//No user and car can reserve and drive simuteneously
fact NoBusyUserCar {
	all r1 : Reservation, r2 : Ride | r1.user != r2.user
	all r1 : Reservation, r2 : Ride | r1.car != r2.car
	no disjoint r1,r2 : Reservation | r1.user = r2.user
	no disjoint r1,r2 : Reservation | r1.car = r2.car
	no disjoint r1,r2 : Ride | r1.user = r2.user
	no disjoint r1,r2 : Ride | r1.car = r2.car
}


//------------ASSERTIONS----------------

assert AvailableCarPosition {
	no c : Car | c.state = AVAILABLE and c.currentPosition in UnSafeArea.points
}

assert ReservedCarPosition {
	no c : Car | c.state = RESERVED and c.currentPosition in UnSafeArea.points
}

assert LowBatteryPunishmentCheck {
	no r : Ride | r.dp.lowBatteryPunishment = True and r.car.battery = MEDIUM
}

//----------------SHOW----------------------

pred example {

/*
	some c : Car | c.state = AVAILABLE 
	some c : Car | c.state = RESERVED
   some c : Car | c.state = CHARGING
	some c : Car | c.state = WORKING
	some c : Car | c.state = UNCHARGING
*/

	#Car = 3
	
}

run example  for 4


check LowBatteryPunishmentCheck
check AvailableCarPosition
check ReservedCarPosition






