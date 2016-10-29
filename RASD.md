## Content
* 1. Introduction
 * 1.1 Description of the given system
 * 1.2 Goals
 * 1.3 Domain Properties
 * 1.4 Glossary
 * 1.5 Stakeholders
* 2. Actors Identifying
* 3. Requirements
* 4. Scenario Identifying
* 5. UML models
* 6. Alloy model
* 7. Working time
 
## Introduction
### The description of the system
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
* Each car has a people detection sensor,as soon as the engine ignites, sensor detects the number of people into the car.
* There will be no car accident which interrupts the users while driving.
* Cars are always connected to the network.

### Glossary
Here presents the detail defination of some common used terms.
* User
* Crendentials
* payment information
* Driver
* Passenger
* Safe area

### Stakeholders

### Actors Identifying
The actors involved in our system is described below:
* User: User logs into the system and performs the payment.(A user can either be a driver or a passenger)
* Driver: The person who dirves the car.
* Passenger: The persons in the car who are not driving.

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
 
* [G9] If the system detects the user took at least two other passengers onto the car, the system applies a discount of 10% on the last ride.
 * The system will receive and will analyze the information retuned from people detection sensor whether more than two passengers onto the cars or not, if it actually go beyond, the system will register a discount of 10% on the last ride
* [G10]If a car is left with no more than 50% of the battery empty, the system applies a discount of 20% on the last ride.
 * After the lock of car, the system will examine the level of battery using battery fuel gauge IC, if over half the battery is remained, then the system will register a discount of 20% on the last ride
* [G11]If a car is left at special parking areas where they can be recharged and the user takes care of plugging the car into the power grid, the system applies a discount of 30% on the last ride.
 * system will register a discount of 30% on the last ride if it recognize the car is parked at special area, and it's charging the battery within a determined time. 
* [G12]If a car is left at more than 3 KM from the nearest power grid station or with more than 80% of the battery empty, the system charges 30% more on the last ride to compensate for the cost required to re-charge the car on-site.
 * system must be able to get always the positin of the cars and all position of power grid station.
 * system will register a increase of 30% on the fee of last ride, if there are not any power grid station within 3KM from the position of car,where is left after using, and the battery will remain less than 20%.
 * system must notice the position of car out of range to the staff, that take care to re-charge these car on-site.
 

### Scenario identifying
#### Scenario 1
Mario is a college student who possesses a driving licence. He saw the ads about PowerEnJoy and decided to try this service. He uses his laptop to access the website of PowerEnjoy and proceeds the registering procedure. He provides his credentials and payment information. After the system analyzes his data, Mario receives a password. He logs into the system and finds some available cars near his place. He selects one car and makes a reservation. 30 minutes later, Mario arrives at the car position and he uses his laptop to notify the system that he is near the car. The system checks his position and unlocks the car. Mario drives home and on the car screen he can see his current driving route and safe areas nearby. He stops the car in one of the safe areas near home and finishes his journey.

#### Scenario 2
Tom is an old user of the PowerEnJoy. After work, he decides to reserve a car to go home. He uses his smart phone to reserve a car and head to it. However, he encounters his colleague on his way and they chat for a while. Before he manages to get to the car, one hour has passed. He receives a message on his phone that tells him his reservation is cancelled and he is charged one euro for punishment. Tom has to log in the system and reserve a car again.

### UML model

### Alloy model
