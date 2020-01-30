//
//  ODUserButtonCell.h
//  ODCoreDataHW
//
//  Created by Дмитрий on 23.01.2020.
//  Copyright © 2020 Дмитрий. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ODUserButtonCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIButton *saveButtonOutlet; 
@property (weak, nonatomic) IBOutlet UIButton *deleteButtonOutlete;


@end

NS_ASSUME_NONNULL_END
