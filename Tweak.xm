static NSIndexPath *messengerDayCellIndexPath = nil;
static NSString *MontageCellReuseIdentifier = @"MONTAGE_COMPOSER";
static NSString *SearchBarPlaceHolderText = @"GIT GUD MESSENGER DEVS";
static BOOL isHidden = NO;

%hook MNThreadListViewController

- (double)tableView:(id)arg1 heightForRowAtIndexPath:(id)arg2
{
    CGFloat height = %orig;
    if (messengerDayCellIndexPath != nil && [arg2 isEqual:messengerDayCellIndexPath]) {
      isHidden = YES;
      return CGFLOAT_MIN;
    }
    return height;
}
%end

%hook UISearchBarTextFieldLabel

- (void)_setText:(id)arg1
{
    %orig(SearchBarPlaceHolderText);
}

%end

%hook UITableView

- (void)_setupCell:(id)arg1 forEditing:(_Bool)arg2 atIndexPath:(id)arg3 animated:(_Bool)arg4 updateSeparators:(_Bool)arg5
{
    %orig;
    UITableViewCell *cell = ((UITableViewCell *)arg1);
    if([cell.reuseIdentifier isEqualToString:MontageCellReuseIdentifier] && !isHidden) {
        messengerDayCellIndexPath = arg3;
        cell.contentView.hidden = YES;
        [self reloadData];
    }
}

%end
