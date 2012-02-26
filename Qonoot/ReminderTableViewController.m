//
//  RemindersTableViewController.m
//  Ghonoot
//
//  Created by Sina on 2/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ReminderTableViewController.h"
#import "LocalNotificationsManager.h"

@interface ReminderTableViewController()
@property (nonatomic, strong) LocalNotificationsManager *lnm;
@property (nonatomic, strong) NSMutableArray *allNotifications;
@end

@implementation ReminderTableViewController

@synthesize showListings;
@synthesize lnm = _lnm;
@synthesize allNotifications = _allNotifications;

- (LocalNotificationsManager *)lnm
{
    if (!_lnm) _lnm = [LocalNotificationsManager sharedManager];
    return _lnm;
}

- (NSArray*)allNotifications
{
    _allNotifications = [NSMutableArray arrayWithArray:[self.lnm getAllNotifications]];
    return _allNotifications;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.allowsMultipleSelection = YES;
    
    if([self.allNotifications count] > 0)
    {
        showListings = YES;
    }else
    {
        showListings = NO;
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *string;
    if(section == 1){
        string = @"Sound: ";
    }else if(section == 2){
        if(showListings)
            string = @"For which times?";
    }
    return string;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    NSString *string;
    if(section == 0){
        //string = @"Turn on reminders for prayer times";
    }else if(section == 1){
            //string = @"Sound:";
    }else if(section == 2){
        if(showListings)
            string = @"You will be reminded...";
    }
    
    return string;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
    {
        return 1;
    }else if(section == 1)
    {
        return 1;
    }else if(section == 2)
    {
        if(showListings)
            return 7;
        else
            return 0;
    }else
    {
        return 0;
    }
}

-(BOOL)reminderForTimeExists:(NSString*)time
{
    for (int i = 0; i < [self.allNotifications count]; i++) 
    {
        UILocalNotification *notification = [self.allNotifications objectAtIndex:i];
        NSString *round = [notification.userInfo valueForKey:@"round"];
        if([round isEqualToString:time])
        {
            return YES;
        }
    }
    
    return NO;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    NSString *cellTitle;
    NSString *cellSubtitle;
    
    if(indexPath.section == 0)
    {
        cellTitle = @"Set Reminder";
        
        UISwitch *onOff = [[UISwitch alloc] init];
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        cell.accessoryView = onOff;
        [onOff setOn:showListings];
        [onOff addTarget:self action:@selector(onOffChanged:) forControlEvents:UIControlEventValueChanged];
        
    }else if(indexPath.section == 1)
    {
        [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
        cellTitle = @"Set Sound";
    }else if(indexPath.section == 2)
    {
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        cell.accessoryView = nil;
        cell.selected = NO;
        
        [cell setAccessoryType:UITableViewCellAccessoryNone];
        
        NSArray *selectedRows = [self.tableView indexPathsForSelectedRows];
        for (int i = 0; i < [selectedRows count]; i++) {
            NSIndexPath *selectedPath = [selectedRows objectAtIndex:i];
            if(selectedPath.section == indexPath.section && 
               selectedPath.row == indexPath.row)
            {
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                break;
            }
        }
        
        if(showListings)
        {
            if(indexPath.row == 0){
                cellTitle = @"All Prayer Times";
                cellSubtitle = @"Reminds you for all times";
            }else if(indexPath.row == 1){
                if([self reminderForTimeExists:@"fajr"])
                {
                    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                }
                cellTitle = @"Fajr";
                cellSubtitle = @"Only for Fajr prayer";
            }else if(indexPath.row == 2){
                if([self reminderForTimeExists:@"sunrise"])
                {
                    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                }
                cellTitle = @"Sunrise";
                cellSubtitle = @"Only for Sunrise";
            }else if(indexPath.row == 3){
                if([self reminderForTimeExists:@"zuhr"])
                {
                    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                }
                cellTitle = @"Zuhr";
                cellSubtitle = @"Only for Zuhr prayer";
            }else if(indexPath.row == 4){
                if([self reminderForTimeExists:@"asr"])
                {
                    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                }
                cellTitle = @"Asr";
                cellSubtitle = @"Only for Asr prayer";
            }else if(indexPath.row == 5){
                if([self reminderForTimeExists:@"maghrib"])
                {
                    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                }
                cellTitle = @"Maghrib";
                cellSubtitle = @"Only for Maghrib prayer";
            }else if(indexPath.row == 6){
                if([self reminderForTimeExists:@"isha"])
                {
                    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
                }
                cellTitle = @"Isha";
                cellSubtitle = @"Only for Isha prayer";
            }
        }
    }
    cell.textLabel.text = cellTitle;
    cell.detailTextLabel.text = cellSubtitle;
    
    return cell;
}

-(void)onOffChanged:(UISwitch*)onOff
{
    if(onOff.isOn == 1)
    {
        showListings = YES;
    }else
    {
        showListings = NO;
        [self.lnm cancelAllNotifications];
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:2] withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1)
    {
        [self performSegueWithIdentifier:@"to sounds" sender:nil];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0)
    {
        
    }else if(indexPath.section == 1)
    {
        [self performSegueWithIdentifier:@"to sounds" sender:nil];
    }else if(indexPath.section == 2)
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if(cell.selected){
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }else{
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
        
        if(indexPath.row == 0)
        {
            NSArray *selectedRows = [self.tableView indexPathsForSelectedRows];
            for (int i = 0; i < [selectedRows count]; i++) {
                NSIndexPath *selectedPath = [selectedRows objectAtIndex:i];
                if(selectedPath.row != 0)
                {
                    [self.tableView deselectRowAtIndexPath:selectedPath animated:YES];
                    UITableViewCell *cell = [tableView cellForRowAtIndexPath:selectedPath];
                    [cell setAccessoryType:UITableViewCellAccessoryNone];
                }
            }
        }else
        {
            
            NSIndexPath *allDaysIndex = [NSIndexPath indexPathForRow:0 inSection:1];
            [self.tableView deselectRowAtIndexPath:allDaysIndex animated:YES];
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:allDaysIndex];
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
        
        NSString *round = @"all";
        if(indexPath.row == 0){
            round = @"all";
        }else if(indexPath.row == 1){
            round = @"fajr";
        }else if(indexPath.row == 2){
            round = @"sunrise";
        }else if(indexPath.row == 3){
            round = @"zuhr";
        }else if(indexPath.row == 4){
            round = @"asr";
        }else if(indexPath.row == 5){
            round = @"maghrib";
        }else if(indexPath.row == 6){
            round = @"isha";
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addLocalNotification" object:round];
    }
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 2)
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if(cell.selected){
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }else{
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        }
        
        NSString *round = @"all";
        if(indexPath.row == 0){
            round = @"all";
        }else if(indexPath.row == 1){
            round = @"fajr";
        }else if(indexPath.row == 2){
            round = @"sunrise";
        }else if(indexPath.row == 3){
            round = @"zuhr";
        }else if(indexPath.row == 4){
            round = @"asr";
        }else if(indexPath.row == 5){
            round = @"maghrib";
        }else if(indexPath.row == 6){
            round = @"isha";
        }
        
        [self.lnm cancelNotification:round];
    }
}

- (void)viewDidUnload {
    [super viewDidUnload];
}
- (IBAction)onDone:(id)sender {
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}
@end
