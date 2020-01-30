//
//  ODDataManager.m
//  ODCoreDataHW
//
//  Created by Дмитрий on 21.12.2019.
//  Copyright © 2019 Дмитрий. All rights reserved.
//

#import "ODDataManager.h"

//
//
//
//static NSString* firstNames[] = {
//    @"Tran", @"Lenore", @"Bud", @"Fredda", @"Katrice",
//    @"Clyde", @"Hildegard", @"Vernell", @"Nellie", @"Rupert",
//    @"Billie", @"Tamica", @"Crystle", @"Kandi", @"Caridad",
//    @"Vanetta", @"Taylor", @"Pinkie", @"Ben", @"Rosanna",
//    @"Eufemia", @"Britteny", @"Ramon", @"Jacque", @"Telma",
//    @"Colton", @"Monte", @"Pam", @"Tracy", @"Tresa",
//    @"Willard", @"Mireille", @"Roma", @"Elise", @"Trang",
//    @"Ty", @"Pierre", @"Floyd", @"Savanna", @"Arvilla",
//    @"Whitney", @"Denver", @"Norbert", @"Meghan", @"Tandra",
//    @"Jenise", @"Brent", @"Elenor", @"Sha", @"Jessie"
//};
//
//static NSString* lastNames[] = {
//
//    @"Farrah", @"Laviolette", @"Heal", @"Sechrest", @"Roots",
//    @"Homan", @"Starns", @"Oldham", @"Yocum", @"Mancia",
//    @"Prill", @"Lush", @"Piedra", @"CODtenada", @"Warnock",
//    @"Vanderlinden", @"Simms", @"Gilroy", @"Brann", @"Bodden",
//    @"Lenz", @"Gildersleeve", @"Wimbish", @"Bello", @"Beachy",
//    @"Jurado", @"William", @"Beaupre", @"Dyal", @"Doiron",
//    @"Plourde", @"Bator", @"Krause", @"Odriscoll", @"Corby",
//    @"Waltman", @"Michaud", @"KobayODhi", @"Sherrick", @"Woolfolk",
//    @"Holladay", @"Hornback", @"Moler", @"Bowles", @"Libbey",
//    @"Spano", @"Folson", @"Arguelles", @"Burke", @"Rook"
//};

@implementation ODDataManager

+(ODDataManager*) sharedManager{
    static ODDataManager* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[ODDataManager alloc] init];
    });
    return manager;
}

-(NSManagedObjectContext*) managedObjectContext{
    if (!_managedObjectContext) {

        _managedObjectContext = ((AppDelegate *)[[UIApplication sharedApplication] delegate]).persistentContainer.viewContext;
    }
    return _managedObjectContext;
}

//-(ODUser*) addRandomUser{
//    ODUser* randomUser = [NSEntityDescription   insertNewObjectForEntityForName:@"ODUser" inManagedObjectContext:self.managedObjectContext];
//    //ODUser* randomUser = [[ODUser alloc] init];
//    randomUser.firstName = firstNames[arc4random_uniform(50)];
//    randomUser.lastName = lastNames[arc4random_uniform(50)];
//    randomUser.email = [NSString stringWithFormat:@"%@@mail.ru", randomUser.firstName];
//    NSLog(@"%@ %@ - %@", randomUser.firstName, randomUser.lastName, randomUser.email);
//    [self.managedObjectContext  save:nil];
//    return randomUser;
//}


#pragma mark - Save method



-(void) saveUserWithFirstName:(NSString*) firstName withLastName:(NSString*) lastName withEmail:(NSString*) email{
    ODUser* user = [NSEntityDescription   insertNewObjectForEntityForName:@"ODUser" inManagedObjectContext:self.managedObjectContext];
      
    user.firstName = firstName;
    user.lastName = lastName;
    user.email = email;
    [self.managedObjectContext  save:nil];
}

-(void) saveTeacherWithFirstName:(NSString*) firstName withLastName:(NSString*) lastName{
    ODTeacher* teacher = [NSEntityDescription   insertNewObjectForEntityForName:@"ODTeacher" inManagedObjectContext:self.managedObjectContext];
      
    teacher.firstName = firstName;
    teacher.lastName = lastName;
    [self.managedObjectContext  save:nil];
    }

-(ODCourse*) saveCourseWithName:(NSString *)courseName courceTeacher:(ODTeacher*) teacher{
    ODCourse* course = [NSEntityDescription   insertNewObjectForEntityForName:@"ODCourse" inManagedObjectContext:self.managedObjectContext];
    course.name = courseName;
    course.teacher = teacher;
    NSLog(@"%@ firstName save", course.teacher);
    [self.managedObjectContext save:nil];
    return course;
}

-(void)saveCourse:(ODCourse *)course{
    ODCourse* courseObj = [NSEntityDescription   insertNewObjectForEntityForName:@"ODCourse" inManagedObjectContext:self.managedObjectContext];
    courseObj = course;
    [self.managedObjectContext   save:nil];
}

-(void)saveUser:(ODUser *)user{
    ODUser* userObj = [NSEntityDescription   insertNewObjectForEntityForName:@"ODUser" inManagedObjectContext:self.managedObjectContext];
    userObj = user;
    [self.managedObjectContext   save:nil];

}

-(void) saveUser:(ODUser*) user withCourse:(ODCourse*) course context:(nonnull NSManagedObjectContext *)context{
    ODUser* userObj = [NSEntityDescription   insertNewObjectForEntityForName:@"ODUser" inManagedObjectContext:context];
      userObj = user;
    userObj.course = course;
    [context   save:nil];

}


- (NSArray*) allUsers {
    
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    
    NSEntityDescription* description =
    [NSEntityDescription entityForName:@"ODUser"
                inManagedObjectContext:self.managedObjectContext];
    
    [request setEntity:description];
    
    NSError* requestError = nil;
    NSArray* resultArray = [self.managedObjectContext executeFetchRequest:request error:&requestError];
    if (requestError) {
        NSLog(@"%@", [requestError localizedDescription]);
    }
    
    return resultArray;
}

#pragma mark - Delete method

-(void) deleteAllUsers{
    NSArray* allUsers = [self allUsers];
       
       for (id user in allUsers) {
           [self.managedObjectContext deleteObject:user];
       }
       [self.managedObjectContext save:nil];
}

-(void) deleteUser:(id) user{
    [self.managedObjectContext   deleteObject:user];
    [self.managedObjectContext save:nil];
}

-(void) deleteCourse:(ODCourse*) course{
    [self.managedObjectContext   deleteObject:course];
    [self.managedObjectContext save:nil];
}

-(void) deleteObject:(id) object{
    [self.managedObjectContext   deleteObject:object];
    [self.managedObjectContext save:nil];
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"ODCoreDataHW"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}




@end
