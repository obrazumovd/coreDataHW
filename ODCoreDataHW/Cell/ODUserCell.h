//
//  ODUserCell.h
//  ODCoreDataHW
//
//  Created by Дмитрий on 23.01.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ODUserCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *LableOutlet;
@property (weak, nonatomic) IBOutlet UITextField *textOutlet;

@end

NS_ASSUME_NONNULL_END
