//
//  ODAddUserViewController.m
//  ODCoreDataHW
//
//  Created by Дмитрий on 21.12.2019.
//  Copyright © 2019 Дмитрий. All rights reserved.
//

#import "ODAddUserViewController.h"
#import "ODAddCourseViewController.h"
#import "ODUserCell.h"
#import "ODUserButtonCell.h"
#import "ODUserCourseCell.h"


static NSString* firstNames[] = {
    @"Tran", @"Lenore", @"Bud", @"Fredda", @"Katrice",
    @"Clyde", @"Hildegard", @"Vernell", @"Nellie", @"Rupert",
    @"Billie", @"Tamica", @"Crystle", @"Kandi", @"Caridad",
    @"Vanetta", @"Taylor", @"Pinkie", @"Ben", @"Rosanna",
    @"Eufemia", @"Britteny", @"Ramon", @"Jacque", @"Telma",
    @"Colton", @"Monte", @"Pam", @"Tracy", @"Tresa",
    @"Willard", @"Mireille", @"Roma", @"Elise", @"Trang",
    @"Ty", @"Pierre", @"Floyd", @"Savanna", @"Arvilla",
    @"Whitney", @"Denver", @"Norbert", @"Meghan", @"Tandra",
    @"Jenise", @"Brent", @"Elenor", @"Sha", @"Jessie"
};

static NSString* lastNames[] = {
    
    @"Farrah", @"Laviolette", @"Heal", @"Sechrest", @"Roots",
    @"Homan", @"Starns", @"Oldham", @"Yocum", @"Mancia",
    @"Prill", @"Lush", @"Piedra", @"CODtenada", @"Warnock",
    @"Vanderlinden", @"Simms", @"Gilroy", @"Brann", @"Bodden",
    @"Lenz", @"Gildersleeve", @"Wimbish", @"Bello", @"Beachy",
    @"Jurado", @"William", @"Beaupre", @"Dyal", @"Doiron",
    @"Plourde", @"Bator", @"Krause", @"Odriscoll", @"Corby",
    @"Waltman", @"Michaud", @"KobayODhi", @"Sherrick", @"Woolfolk",
    @"Holladay", @"Hornback", @"Moler", @"Bowles", @"Libbey",
    @"Spano", @"Folson", @"Arguelles", @"Burke", @"Rook"
};

@interface ODAddUserViewController ()

@property (strong, nonatomic) NSString* randomFirstName;
@property (strong, nonatomic) NSString* randomLastName;
@property (strong, nonatomic) NSString* randomEmail;


@end

@implementation ODAddUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.firstName = [[UITextField alloc] init];
    self.lastName = [[UITextField alloc] init];
    self.email = [[UITextField alloc] init];
    
    if (self.user) {
        self.firstName.text = self.user.firstName;
        self.lastName.text = self.user.lastName;
        self.email.text = self.user.email;
    }
}

-(void)randomUserGenerator{
    
    self.firstName.text = firstNames[arc4random_uniform(50)];
    self.lastName.text  = lastNames[arc4random_uniform(50)];
    self.email.text = [NSString stringWithFormat:@"%@@mail.ru", self.firstName.text];
       NSLog(@"%@ %@ - %@", self.firstName.text, self.lastName.text, self.email.text);

}

- (void)viewWillDisappear:(BOOL)animated{
    [self saveContext];
}

-(void) saveContext{
    if (self.user && ![self.firstName.text isEqualToString:(@"")] && ![self.lastName.text isEqualToString:(@"")]) {
        self.user.firstName = self.firstName.text;
        self.user.lastName = self.lastName.text;
        self.user.email = self.email.text;
        [[ODDataManager sharedManager].managedObjectContext save:nil];
    }else  if (![self.firstName.text isEqualToString:(@"")] && ![self.lastName.text isEqualToString:(@"")]) {
        
        [[ODDataManager sharedManager] saveUserWithFirstName:self.firstName.text withLastName:self.lastName.text withEmail:self.email.text];
    }
    
}

#pragma mark - Action

- (IBAction)randomButton:(id)sender {
    
    [self randomUserGenerator];
}

- (IBAction)saveButton:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)deleteButton:(id)sender {
    if (self.user) {
        [[ODDataManager sharedManager] deleteUser:self.user];
    }
    self.firstName.text = @"";
    self.lastName.text = @"";
    self.email.text = @"";
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 1) {
      
        return [[self.user.course allObjects] count];
    } else{
        return 4;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return @"User";
    }else{
        return @"Learning course";
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        static NSString *Identifier = @"Cell";
        ODUserCell* cell = [tableView dequeueReusableCellWithIdentifier:Identifier];
        if (indexPath.row == 0) {
            cell.LableOutlet.text = @"First name";
            //cell.textOutlet.text = self.user.firstName;
            
            cell.textOutlet.text = self.firstName.text;
            self.firstName = cell.textOutlet;

            
        }
        if (indexPath.row == 1) {
            cell.LableOutlet.text = @"Last name";
            cell.textOutlet.text = self.user.lastName;
            self.lastName = cell.textOutlet;
        }
        if (indexPath.row == 2) {
            cell.LableOutlet.text = @"E-mail";
            cell.textOutlet.text = self.user.email;
            self.email = cell.textOutlet;
        }
        
        if (indexPath.row == 3) {
            ODUserButtonCell* btnCell = [tableView dequeueReusableCellWithIdentifier:@"CellButton"];
            [btnCell.saveButtonOutlet addTarget:self action:@selector(saveButton:) forControlEvents:UIControlEventTouchUpInside];
            [btnCell.deleteButtonOutlete addTarget:self action:@selector(deleteButton:) forControlEvents:UIControlEventTouchUpInside];
            return btnCell;
            
        }
        
        return cell;
    }else{
        static NSString *IdentifierCource = @"CellCourse";
        ODUserCourseCell* cell = [tableView dequeueReusableCellWithIdentifier:IdentifierCource];
        ODCourse* course = [[self.user.course allObjects] objectAtIndex:indexPath.row];
        cell.courseLableOutlete.text = course.name;
        return cell;
        
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        
        UIStoryboard *storyboard = [UIStoryboard    storyboardWithName:@"Main" bundle:nil];
        UITabBarController* tb = (UITabBarController*)[storyboard instantiateViewControllerWithIdentifier:@"CourseTabBarController"];
        ODAddCourseViewController* vc = (ODAddCourseViewController*)[tb.viewControllers objectAtIndex:0];
        vc.course = [[self.user.course allObjects] objectAtIndex:indexPath.row];
        [tb setSelectedViewController:vc];

        [self.navigationController pushViewController:tb animated:YES];
    }
}
@end
