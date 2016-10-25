## Introduction
### The description of the problem
We are required to deveplop a digital management system for a car-sharing service. More precisely, this system can be accessed by the clients from a mobile deivce and processed by a server. The system provides electric cars renting service. The registered users can search available cars, make reservations, acquire current charging fees.
Moreover, the system has certain mechanics to incentivize the virtuous behaviours of the users, which includes creating discount of the charging fees or increasing the charging fees.

### Goals
* [G1]Users can register to the system and get the password by providing credentials and payment information
* [G2]Registered users can find the locations of available cars within a certain distance from their current location or from a specified address.
* [G3]Among the available cars in a certain geographical region, users must be able to reserve a single car for up to one hour before they pick it up.
* [G4]If a car is not picked‐up within one hour from the reservation, the system tags the car as available again, and the reservation expires; the user pays a fee of 1 EUR.
* [G5]A user that reaches a reserved car must be able to tell the system she’s nearby, so the system unlocks the car and the user may enter.
* [G6]As soon as the engine ignites, the system starts charging the user for a given amount of money per minute; the user is notified of the current charges through a screen on the car.
* [G7]The system stops charging the user as soon as the car is parked in a safe area and the user exits the car; at this point, the system locks the car automatically.
* [G8]The set of safe areas for parking cars is pre-defined by the management system.
* [G9]If the system detects the user took at least two other passengers onto the car, the system applies a discount of 10% on the last ride.
* [G10]If a car is left with no more than 50% of the battery empty, the system applies a discount of 20% on the last ride.
* [G11]If a car is left at special parking areas where they can be recharged and the user takes care of plugging the car into the power grid, the system applies a discount of 30% on the last ride.
* [G12]If a car is left at more than 3 KM from the nearest power grid station or with more than 80% of the battery empty, the system charges 30% more on the last ride to compensate for the cost required to re-charge the car on-site.
* [G13]If the user enables the money saving option, he/she can input his/her final destination and the system provides information about the station where to leave the car to get a discount. This station is determined to ensure a uniform distribution of cars in the city and depends both on the destination of the user and on the availability of power plugs at the selected station.

### Domain properties
We suppose the following statements hold in the analyzed world.
* The credentials and payment information provided by the users are correct.
* Assume that the credits in the users credit cards or bank accounts are always enough.
* Each car and users' mobile devices contain GPS and the GPS works correctly.
* There will not be a case when the user is driving and the car is out of power.

### Requirements
Assuming all the domain properties hold and we derive the correspondong requirements from the goals.
* [G1]Users can register to the system and get the password by providing credentials and payment information
  * The system must let only one registeration per credential.
  * The system must be able to check whether the payment information is correct or not
  * The system must create and mantain only one password per credential
  * The system must check whether the password is correct under the credential
  * The system must allow users to login when provided with the correct credential and password
* [G2]Registered users can find the locations of available cars within a certain distance from their current location or from a specified address
 * The system must be able to get all the locations of the cars
 * The system has a default range which identifies the term "nearby"
 * The system must be able to get all the information of the nearby cars with a certain locaiton as input
* [G3]Among the available cars in a certain geographical region, users must be able to reserve a single car for up to one hour before they pick it up.
 * The system must allow users to reserve a single car
 * The system maintains a clock for each car. Once the car is resvered by a user, a one-hours time clock starts
* [G4]If a car is not picked‐up within one hour from the reservation, the system tags the car as available again, and the reservation expires; the user pays a fee of 1 EUR.
 * The system must allow the user who has made a reservation for a car to stop the clock of that car
 * The system must charge the user 1 euro for not being able to stop the clock within one hour
 * The system will make the car state changed to available if the clock is not stopped within in one hour
  
