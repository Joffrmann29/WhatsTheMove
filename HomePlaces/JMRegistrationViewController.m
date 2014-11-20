//
//  RegistrationViewController.m
//  GaTechScouting
//
//  Created by Joffrey Mann on 11/6/14.
//  Copyright (c) 2014 JoffreyMann. All rights reserved.
//
#define kOFFSET_FOR_KEYBOARD 80.0
#import "RegistrationViewController.h"

@interface RegistrationViewController ()<UIGestureRecognizerDelegate>

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UITextField *firstNameField;
@property (strong, nonatomic) UITextField *lastNameField;
@property (strong, nonatomic) UITextField *userField;
@property (strong, nonatomic) UITextField *passField;
@property (strong, nonatomic) UITextField *confirmPassField;
@property (strong, nonatomic) UITextField *emailField;
@property (strong, nonatomic) UITextField *userTypeField;
@property (strong, nonatomic) UITextField *groupField;
@property (strong, nonatomic) UIButton *registrationButton;
@property (strong, nonatomic) UIScrollView *scrollView;

@end

@implementation RegistrationViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    UINavigationBar *navBar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 50)];
    [navBar setTintColor:[UIColor blackColor]];
    navBar.barTintColor = [UIColor whiteColor];
    [self.view addSubview:navBar];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    
    UINavigationItem *navItem = [[UINavigationItem alloc] initWithTitle:@"Create Your iScout Account"];
    [navItem setLeftBarButtonItem:backItem animated:YES];
    [navBar setItems:[NSArray arrayWithObject:navItem] animated:YES];
    [self.view addSubview:navBar];
    self.firstNameField.delegate = self;
    self.lastNameField.delegate = self;
    self.userField.delegate = self;
    self.passField.delegate = self;
    self.confirmPassField.delegate = self;
    self.emailField.delegate = self;
    self.userTypeField.delegate = self;
    self.groupField.delegate = self;
    self.scrollView.delegate = self;
    //self.scrollView.frame = self.view.frame;
    self.scrollView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height*2);
    
    CGRect titleRect = CGRectMake(50, 40, 235, 30);
    CGRect firstNameRect = CGRectMake(50, 90, 210, 30);
    CGRect lastNameRect = CGRectMake(50, 140, 210, 30);
    CGRect userRect = CGRectMake(50, 190, 210, 30);
    CGRect passRect = CGRectMake(50, 240, 210, 30);
    CGRect confirmRect = CGRectMake(50, 290, 210, 30);
    CGRect emailRect = CGRectMake(50, 340, 210, 30);
    CGRect userTypeRect = CGRectMake(50, 390, 210, 30);
    CGRect groupRect = CGRectMake(50, 440, 210, 30);
    CGRect registrationRect = CGRectMake(75, 490, 160, 30);
    
    self.titleLabel = [[UILabel alloc]initWithFrame:titleRect];
    self.firstNameField = [[UITextField alloc]initWithFrame:firstNameRect];
    self.lastNameField = [[UITextField alloc]initWithFrame:lastNameRect];
    self.userField = [[UITextField alloc]initWithFrame:userRect];
    self.passField = [[UITextField alloc]initWithFrame:passRect];
    self.confirmPassField = [[UITextField alloc]initWithFrame:confirmRect];
    self.emailField = [[UITextField alloc]initWithFrame:emailRect];
    self.userTypeField = [[UITextField alloc]initWithFrame:userTypeRect];
    self.groupField = [[UITextField alloc]initWithFrame:groupRect];
    self.registrationButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.registrationButton addTarget:self
                                action:@selector(addUser:)
                      forControlEvents:UIControlEventTouchUpInside];
    [self.registrationButton setTitle:@"Create Account" forState:UIControlStateNormal];
    self.registrationButton.frame = registrationRect;
    self.registrationButton.backgroundColor = [UIColor blackColor];
    
    CAGradientLayer *viewGradient = [CAGradientLayer layer];
    viewGradient.frame = self.view.bounds;
    viewGradient.colors = [NSArray arrayWithObjects:
                           (id)[[UIColor colorWithRed:42.0f / 255.0f green:92.0f / 255.0f blue:252.0f / 255.0f alpha:1.0f] CGColor],
                           (id)[[UIColor colorWithRed:11.0f / 255.0f green:51.0f / 255.0f blue:101.0f / 255.0f alpha:1.0f] CGColor],
                           nil];
    [self.view.layer insertSublayer:viewGradient atIndex:0];
    
    self.firstNameField.backgroundColor = [UIColor blackColor];
    self.lastNameField.backgroundColor = [UIColor blackColor];
    self.userField.backgroundColor = [UIColor blackColor];
    self.passField.backgroundColor = [UIColor blackColor];
    self.confirmPassField.backgroundColor = [UIColor blackColor];
    self.emailField.backgroundColor = [UIColor blackColor];
    self.userTypeField.backgroundColor = [UIColor blackColor];
    self.groupField.backgroundColor = [UIColor blackColor];
    
    self.firstNameField.textColor = [UIColor whiteColor];
    self.lastNameField.textColor = [UIColor whiteColor];
    self.userField.textColor = [UIColor whiteColor];
    self.passField.textColor = [UIColor whiteColor];
    self.confirmPassField.textColor = [UIColor whiteColor];
    self.userTypeField.textColor = [UIColor whiteColor];
    self.groupField.textColor = [UIColor whiteColor];
    
    self.firstNameField.placeholder = @"First Name";
    self.lastNameField.placeholder = @"Last Name";
    self.userField.placeholder = @"Username";
    self.passField.placeholder = @"Password";
    self.confirmPassField.placeholder = @"Confirm Password";
    self.emailField.placeholder = @"E-mail";
    self.userTypeField.placeholder = @"User Type";
    self.groupField.placeholder = @"Group";
    
    UIColor *textfieldPlaceholderColor = [UIColor darkGrayColor];
    [self.firstNameField setValue:textfieldPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.lastNameField setValue:textfieldPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.userField setValue:textfieldPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.passField setValue:textfieldPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.confirmPassField setValue:textfieldPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.emailField setValue:textfieldPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.userTypeField setValue:textfieldPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    [self.groupField setValue:textfieldPlaceholderColor forKeyPath:@"_placeholderLabel.textColor"];
    
    self.firstNameField.layer.cornerRadius = 10;
    self.lastNameField.layer.cornerRadius = 10;
    self.userField.layer.cornerRadius = 10;
    self.passField.layer.cornerRadius = 10;
    self.confirmPassField.layer.cornerRadius = 10;
    self.emailField.layer.cornerRadius = 10;
    self.userTypeField.layer.cornerRadius = 10;
    self.registrationButton.layer.cornerRadius = 10;
    self.groupField.layer.cornerRadius = 10;
    
    //self.titleLabel.text = @"Create Your iScout Account";
    //[self.view addSubview:self.scrollView];
    [self.view addSubview:self.firstNameField];
    [self.view addSubview:self.lastNameField];
    [self.view addSubview:self.userField];
    [self.view addSubview:self.passField];
    [self.view addSubview:self.confirmPassField];
    [self.view addSubview:self.emailField];
    [self.view addSubview:self.userTypeField];
    [self.view addSubview:self.groupField];
    [self.view addSubview:self.registrationButton];
    [self.view addSubview:self.titleLabel];
    [self.passField setSecureTextEntry:YES];
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToDismissKeyboard:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.numberOfTouchesRequired = 1;
    singleTap.delegate = self;
    [self.view addGestureRecognizer:singleTap];
    
    [self.firstNameField addTarget:self
                       action:@selector(textFieldDidChange)
             forControlEvents:UIControlEventEditingDidBegin];
    
    [self.lastNameField addTarget:self
                       action:@selector(textFieldDidChange)
             forControlEvents:UIControlEventEditingDidBegin];
    
    [self.userField addTarget:self
                       action:@selector(textFieldDidChange)
             forControlEvents:UIControlEventEditingDidBegin];
    
    [self.passField addTarget:self
                       action:@selector(textFieldDidChange)
             forControlEvents:UIControlEventEditingDidBegin];
    
    [self.confirmPassField addTarget:self
                       action:@selector(textFieldDidChange)
             forControlEvents:UIControlEventEditingDidBegin];
    
    [self.emailField addTarget:self
                              action:@selector(textFieldDidChange)
                    forControlEvents:UIControlEventEditingDidBegin];
    
    [self.userTypeField addTarget:self
                        action:@selector(textFieldDidChange)
              forControlEvents:UIControlEventEditingDidBegin];
    
    [self.groupField addTarget:self
                           action:@selector(textFieldDidChange)
                 forControlEvents:UIControlEventEditingDidBegin];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)tapToDismissKeyboard:(UITapGestureRecognizer *)recognizer {
    
    // CGPoint location = [recognizer locationInView:self.view]; // self.view will always be the same. You need to use the view on which the user tapped. It's `recognizer.view`
    
    CGPoint loc = [recognizer locationInView:recognizer.view];
    
    [self resignKeyboard];
}

-(void)textFieldDidChange
{
    //move the main view, so that the keyboard does not hide it.
    if  (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"Scrolling");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addUser:(UIButton *)sender
{
    PFUser *newUser = [PFUser user];
     newUser.username = self.userField.text;
     newUser.password = self.passField.text;
    
     
     [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
     if (!error){
     UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Success" message:@"Your iScout account has been successfully created" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
     [alert show];
     [self performSegueWithIdentifier:@"toProfile" sender:nil];
     }
     else{
     NSLog(@"%@", error);
     NSString *errorString = [[error userInfo] objectForKey:@"error"];
     UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Error" message:errorString delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
     [errorAlertView show];
     }
     }];
}

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


-(void)resignKeyboard
{
    [self.firstNameField resignFirstResponder];
    [self.lastNameField resignFirstResponder];
    [self.userField resignFirstResponder];
    [self.passField resignFirstResponder];
    [self.confirmPassField resignFirstResponder];
    [self.emailField resignFirstResponder];
    [self.userTypeField resignFirstResponder];
    [self.groupField resignFirstResponder];
    
    if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
