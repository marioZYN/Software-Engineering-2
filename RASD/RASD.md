## Content
* 1. Introduction
 * 1.1 Description of the given system
 * 1.2 Goals
 * 1.3 Domain Properties
 * 1.4 Glossary
 * 1.5 Assumpption
 * 1.6 Stakeholders
* 2. Actors Identifying
* 3. Requirements
 * 3.1 Functional requirements
 * 3.2 Non functional requirements
* 4. Scenario Identifying
* 5. UML models
 * 5.1 Use case diagram 
 * 5.2 Use case description
* 6. Alloy model
* 7. Working time
 
## 1 Introduction
### 1.1 The description of the system
We are required to deveplop a digital management system for a car-sharing service. More precisely, this system can be accessed by the clients from a mobile deivce and processed by a server. The system provides electric cars renting service. The registered users can search available cars, make reservations, acquire current charging fees.
Moreover, the system has certain mechanics to incentivize the virtuous behaviours of the users, which includes creating discount of the charging fees or increasing the charging fees.

### 1.2 Goals
* [G1]Users can register to the system and get the password by providing credentials and payment information  

* [G2]Registered users can find the locations of available cars within a certain distance from their current location or from a specified address.
* [G3]Among the available cars in a certain geographical region, users must be able to reserve a single car for up to one hour before they pick it up.
* [G4]If a car is not picked‐up within one hour from the reservation, the system tags the car as available again, and the reservation expires; the user pays a fee of 1 EUR.
* [G5]A user that reaches a reserved car must be able to tell the system he’s nearby, so the system unlocks the car and the user may enter.
* [G6]As soon as the engine ignites, the system starts charging the user for a given amount of money per minute; the user is notified of the current charges through a screen on the car.
* [G7]The system stops charging the user as soon as the car is parked in a safe area and the user exits the car; at this point, the system locks the car automatically.
* [G8]The set of safe areas for parking cars is pre-defined by the management system.
* [G9]If the system detects the user took at least two other passengers onto the car, the system applies a discount of 10% on the last ride.
* [G10]If a car is left with no more than 50% of the battery empty, the system applies a discount of 20% on the last ride.
* [G11]If a car is left at special parking areas where they can be recharged and the user takes care of plugging the car into the power grid, the system applies a discount of 30% on the last ride.
* [G12]If a car is left at more than 3 KM from the nearest power grid station or with more than 80% of the battery empty, the system charges 30% more on the last ride to compensate for the cost required to re-charge the car on-site.
* [G13]If the user enables the money saving option, he/she can input his/her final destination and the system provides information about the station where to leave the car to get a discount. This station is determined to ensure a uniform distribution of cars in the city and depends both on the destination of the user and on the availability of power plugs at the selected station.

### 1.3 Domain properties  
We suppose the following statements hold in the analyzed world.

* The credentials and payment information provided by the users are correct.
* Assume that the credits in the users credit cards or bank accounts are always enough.
* Each car and safe area and users' mobile devices contain GPS and the GPS works correctly.
* Each car has a way to determine the number of people into the car.
* Each car knows when to lock the car after user leaves it.
* Each car knows its own battery's state(percent of battery empty,charging).
* Users can not leave the car while driving.
* Cars are always connected to the network.  
* The system always sends the message to user when it is necessary.
* There is a timer to take care of the management of some operations.
* There are maintainers to take care of charging the battery of cars.
* There are maintainers in the stations.
* There will be no car accident which interrupts the users while driving.

### 1.4 Glossary
Here presents the detail defination of some common used terms.

* Guest
	* Guests are people who haven't performed the log in operation.They may be registered clients or unregistered clients. As long as they have not performed log in, they are guests.

* User
	* Refer to the clients who have performed log in, 

* Credentials
	* Some personal information about each user, including:
	* Name
	* E_mail address
	* Phone number
	* Number of drive license

* Payment information
	* Number of the bank acount or credit card
	* Expired time
	* Security code 
	* Holder name

* Driver
	* He is the driver of the renting car. According to the regulations, only the user who rent the car can drive. 

* Passenger
	* People on the car, other than the driver.

* Safe area
	* a set of location predefined as being safe
	* it may has the power plug or may not.

* Station 
	* stations are always safe areas with power plug. 

### 1.5 Assumption
There are some information that is not clear in the specification document, so here lists the assumptions which make the specification more clear.

* The available cars are the cars with full battery 
* The available cars are the cars in the safe areas
* Since only the user uploads the information of the driving licence, only the user can act as a driver while passengers can not.



### 1.6 Stakeholders
* There would be two main stakeholders
	* One is the company who provides this service system and earns money from it
	* <del>The other is the government who wants to get a more usable and convenient renting system</del>

## 2 Actors Identifying
The actors involved in our system is described below  

* Guest: A potential user who has not registered yet
* User: User logs into the system and performs the payment.(The driver can only be the user)

## 3 Requirements

### 3.1 Funcitonal requirements

Assuming all the domain properties hold and we derive the correspondong requirements from the goals.

* [G1]Users can register to the system and get the password by providing credentials and payment information
  * The system must let only one registeration per credential.
  * The system must be able to check whether the payment information is correct or not.
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
 * The system must allow the user who has made a reservation for a car to stop the clock of that car within one hour picking up time
 * The system must charge the user 1 euro for not being able to stop the clock within one hour
 * The system will make the car state changed to available if the clock is not stopped within in one hour
 
* [G5]A user that reaches a reserved car must be able to tell the system she’s nearby, so the system unlocks the car and the user may enter.
 * The system must be able to check the position of the user according to the user's GPS
 * The system must be able to check the position of the car according to the car's GPS
 * The system should be able to receive the messages which are sent by different users as the same time
 * The system should be able to check whether the postition of the user is the same as the corresponding car
 * If the user and the corresponding car are in the same position, the system must transfer the control information to the appropriate car for unlocking the car
 * If the user and the corresponding car are not in the same position, the system must be able to keep the car locked
  
* [G6]As soon as the engine ignites, the system starts charging the user for a given amount of money per minute; the user is notified of the current charges through a screen on the car.
 * The system must be able to detect whether the engine of the car is ignited or not
 * The system must be able to record the total using time
 * The system must be able to estimate the total fee during the renting servece
 * The system must be able to transfer the charging informatin to the appropriate car
  
* [G7]The system stops charging the user as soon as the car is parked in a safe area and the user exits the car; at this point, the system locks the car automatically.
 * The system must be able to check the position of the car according to the car's GPS
 * The system must be able to detect whether the car is parked or not
 * The system must be able to check whether the car is parked in the safe area
 * The system must be able to detect whether the user has exited the car
 * if the user still stay in the car, the system must be able to keep the car in the unlocked state
 * if the car is not parked in the safe area, the system must be able to keep the car in the unlocked state and keep charging
 * The system must let the user know whether the car is in the safe area
 * if the car is parked in the safe area and the user has exited the car, the system must be able to transfer the control information for locking the car
  
* [G8]The set of safe areas for parking cars is pre-defined by the management system.
 * The system must be able to insert the area in the safe area set
 * The system must be able to delete the area in the safe area set
 * The system must be able to retrieve the area in the safe area set
 * <del>The system must be able to replace the area in the safe area set</del>
 
* [G9] If the system detects the user took at least two other passengers onto the car, the system applies a discount of 10% on the last ride.
 * The system will analyze whether more than two passengers,excluding driver, onto the cars or not, if it actually goes beyond, the system will register a discount of 10% on the last ride

* [G10]If a car is left with no more than 50% of the battery empty, the system applies a discount of 20% on the last ride.
 * After the lock of car, the system will examine the level of battery, if over half the battery is remained, then the system will register a discount of 20% on the last ride

* [G11]If a car is left at special parking areas where they can be recharged and the user takes care of plugging the car into the power grid, the system applies a discount of 30% on the last ride.
 * system will register a discount of 30% on the last ride if it recognize the car is parked at special area, and it's charging the battery within a determined time. 

* [G12]If a car is left at more than 3 KM from the nearest power grid station or with more than 80% of the battery empty, the system charges 30% more on the last ride to compensate for the cost required to re-charge the car on-site.
 * system must be able to get the positions of the cars and all positions of power grid stations.
 * system will record an increase of 30% on the fee of last ride, if there are not any power grid stations within 3KM from the position of car or the car is left with no more than 20% of battery.
 * system must inform the maintainers to retrive the cars with low battery to the stations.
* [G13]If the user enables the money saving option, he/she can input his/her final destination and the system provides information about the station where to leave the car to get a discount. This station is determined to ensure a uniform distribution of cars in the city and depends both on the destination of the user and on the availability of power plugs at the selected station.
	* The system must be able to get the distribution of the cars
	* The system must be able to detect whether the user enables the money saving option or not
	* The system must be able to select the station according to the user's destination for ensuring a uniform distribution of the cars
	* The system must be able to detect the availability of power plugs at the selected station

### 3.2 Non functional requirements


## 4 Scenario identifying
#### Scenario 1
Mario is a college student who possesses a driving licence. He saw the ads about PowerEnJoy and decided to try this service. He uses his laptop to access the website of PowerEnjoy and proceeds the registering procedure. He provides his credentials and payment information. After the system analyzes his data, Mario receives a password. He logs into the system and finds some available cars near his place. He selects one car and makes a reservation. 30 minutes later, Mario arrives at the car position and he uses his laptop to notify the system that he is near the car. The system checks his position and unlocks the car. Mario drives home and on the car screen he can see his current driving route,charges and safe areas nearby. He stops the car in one of the safe areas near home and finishes his journey.

#### Scenario 2
Tom is an old user of the PowerEnJoy. After work, he decides to reserve a car to go home. He uses his smart phone to reserve a car and head to it. However, he encounters his colleague on his way and they chat for a while. Before he manages to get to the car, one hour has passed. He receives a message on his phone that tells him his reservation is cancelled and he is charged one euro for punishment. Tom has to log in the system and reserve a car again.

#### Scenario 3  
Nino is a college student. Meanwhile, he is also a user of the PowerEnjoy. He students in the university together with two of his roommates. Finishing his lectures at the afternoon, Nino comes back home together with his roommates. First of all, Nino login to the PowerEnJoy system using his smart phone. Then, he reserve a car and arrive at the position of the car. Nino pick it up and drive the car home. 40 minutes later, Nino stops the car at one the safe locations near his home. Since there are 2 passengers in the car in this renting service, Nino gets 10% discount for the total renting fee.

#### Scenario 4
Gino is a employee of the technology company. Everyday, Gino rents the electric car for commute. He is an old user of the PowerEnJoy. In the morning, He rents a car from th safe area nearby his home. Driving the renting car to the company, he stops the car in the safe area in front of the company. After exiting the car, Gino  takes care of plugging the car into the power grid. After work, Gino rents a electric car in PowerEnJoy system by his smartphone once again. When he arrives at home, he takes care of plugging the car into the power grid as the same as what he did in the morning. Therefore, he get 30% of discount for these two renting services in the whole day.

####Scenario 5
Matteo is a college student who lives in a university residence,where is placed into another city different from his parents' one. At Christmas hoiday, he decide to go back to parents' home with PowerEnjoy. After being restered and logged in  the system, he reserves a car extremaly close to the residence. He take immediately the car and drive at home. He arrives almost at 22:00, unfortunately, there is not any safe area with power plugs within 3km from his home, and the battery is less than 15%. So Matteo parks the car at near safe area without plugs. Due to a scarce battery remained and large distance from power plugs, Matteo pay 30% more on the trip.

####Scenario 6
Andrea is new emploee of a company and he is a expert user, and he have already enabled the money saving option. During a holiday, he organize a picnic at outside the city with other 4 friends. They decide to meet at railroad station and then go to others place together. Before Andrea arrive station, he inserts the position of station into system, and he reserve a car near the address given, and the destination they want to go, then system gives several option to take discount. They successfully pick up the car within one hour, and begin their journey. After they arrive the destination, Andrea parks the car into safe area and plugging the car into power grid,even though the car has still more than 70% of battery. Therefore, he get 10% for taking more than two passegers, 20% for using less battery, and 30 % for plugging the care, all bonus into once ride.
### 5 UML model

#### 5.1 Use case diagram
![use case diagram][]

#### 5.2 Use case description
(1)Guest registers in the system   
**Name**: Guest registers in the system  
**Actor**: Guest  
**Entry condition**: No  
**Flow of events**:  

* The user enters the web home page or opens the mobile app and clicks "Sign up"
* The user fills in the credentials
* The user fills in the payment information
* The system gives the user a password for loging in 

**Exit condition**: The user receives password from his/her email box.  
**Exceptions**:
 
* The user misses information during filling blanks. 
* The user has already registered with the same credentials. 
* the user's credentials or payment information are not correct.  

**Exceptions handling**: The user can either continue filling all the correct information or terminates the registering process.

(2)Guest logs in to the system   
**Name**: Guest logs in  to the system  
**Actor**: Guest  
**Entry condition**: The guest provides correct email address and password  
**Flow of events**:  

* The user enters his/her email address and password
* The user pushes the "log in " button
* The system redirects the user to his personal home page

**Exit condition**: The user is redirected to the personal home page.  
**Exceptions**: 

* The system database can not find registering information of this current email address.  
* The user provides wrong match between email address and password.

**Exception handlings**: In either case, the user can choose to continue filling the blanks until correct match occurs or the user can exit the process.

(3)User reserves an available car   
**Name**: User reserves an available car  
**Actor**: User  
**Entry condition**: The user successfully login with his/her e_mail address and password  
**Flow of events**:  

* The user clicks on the "From current address" button or sets the "From specified address" box to the desired value. 
* The user sets the "Certain distance" to the desired value.
* The system notifies the user with the available cars within the desired distance of desired address.
* The user selects one of the available cars 
* The user clicks on the "Reserve this car" button.
* The system notifies the user for the reservation has been done.

**Exit condition**: The user receives the notification about the reservation is completed and clicks the buttom "Confirm".  
**Exception**:

* There is no available car within desired distance of desired address.
* The user does not want to reserve any of the available car
* The desired car has been reserved before the user completes the reservation

**Exception handing**: The user can reset the desired distance and desired address, or select another available car. The user can also cancel this reservation.

(4)User starts renting   
**Name**:User starts renting  
**Actor**:User  
**Entry condition**:The user has reserved a car and pick it up within 1 hour  
**Flow of events**:

* The user notifies the system with his/her nearby.
* The system checks his/her location and unlocks the corresponding car.
* The user enters the car and ignites the engine.
* The system starts charging.

**Exit condition**:The user is notified of the current charges through a screen on the car.
**Exception**:The position of the user is not as the same as the position of the corresponding car.  
**Exception handing**:The system should notify the user that he/she is not in the correct position


(5)User ends renting  
**Name**:User ends renting  
**Actor**:User  
**Entry condition**:The user has started the renting successfully  
**Flow of events**:

* The user parks the renting car in the safe area.
* The user exits the car.
* The system locks the car automatically.
* The system detects the passenger in this renting service, if the passenger is no less then 2, applies 10% discount for this renting service.
* The system detects the battery remaining amount, if the battery is no more than 50% empty, applies 20% discount for this renting service.
* The system detects whether the car is plugged into the power gird or not, if yes, applies 30% discount for this renting service.
* The system detects the position of the car, if the car is 3KM away from the power station and the battery is more than 80% empty, charges 30% more for this renting service. 

**Exit condition**:The system calculate out the total fee for this renting servcie  
**Exception**:The user does not park the car in the safe area.  
**Exception handing**:The system notifies the user that he/she does not park the car in the correct position.  

(6)User enables save option  
**Name**:User enables save option   
**Actor**:User   
**Entry condition**:User has started the renting successfully  
**Flow of events**:

* The user clicks the "Money saving option" button.
* The user sets the "Destination" to the desired value.
* The system tells the user about the station where the user should park the car in.
  
**Exit condition**: The user receives the message about where to park the car. 
**Exception**:There is no station for user to park the car.  
**Exception handing**:The user can either reset the destination or cancel this application.  

(7)Maintainer charges the electric car  
**Name**:Maintainer charges the electric car  
**Actor**:Maintainer  
**Entry condition**:The user does not park the car in the power grid station or does not plug the car into the power grid.
**Flow of events**:

* The user parks the car in the station without power grid or leaves the car without charging.
* The maintainer sent the message to the system for asking authotity.
* The system unlocks the corresponding car.
* The maintainer restart the car.
* The maintainer plugs the power grid into the car.
* The maintainer exits the car.
* The system locks the car.
  
**Exit condition**:The system receives the confirmation about the car is plugged into the power grid.  
**Exception**:

* There is not available power grid in the corresponding station
* The car is out of power in the way to the power grid station
  
**Exception handing**:  

* The maintainer changes others power grid station for charging the car.
* The maintainer asks for special assistance.

(8)Maintainer records the user who does not charge the car  
**Name**:Maintainer records the user who does not charge the car  
**Actor**:Maintainer  
**Entry condition**:The user does not park the car in the power grid station or does not plug the car into the power grid.  
**Flow of events**:

* The user does not park the car in the power grid station or does not plug the car into the power grid.
* The maintainer send the message to the system for reporting the code of the car.
* The system retrieves the car and the corresponding user.
* The system send the confirmation to the maintainer. 
  
**Exit condition**:The maintainer receives the confirmation  
**Exception**:There is no available power grid in the corresponding station.    
**Exception handing**:The maintainer send the message to the system for reporing there is no power grid available.  
 
### Alloy model
