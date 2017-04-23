//
//  TagesControl.m
//  
//
//  Created by 王琳琳 on 17/3/8.
//
//

#import "TagesControl.h"

@implementation TagesControl{
    
    UITextField * _tagInputfield;
    NSMutableArray *_tagSubviews;
    

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    self = [super init];
    
    if (self != nil) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self != nil) {
        [self commonInit];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame andTags:(NSArray *)tags  {
    self = [super initWithFrame:frame];
    
    if (self != nil) {
        [self commonInit];
        [self setTags:[[NSMutableArray alloc]initWithArray:tags]];
       
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self != nil) {
        [self commonInit];
    }
    
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self commonInit];
}

- (void)commonInit {
    _tags = [NSMutableArray array];
    
    self.layer.cornerRadius = 1;
    
    _tagSubviews = [NSMutableArray array];
    
    _tagInputfield = [[UITextField alloc] initWithFrame:self.frame];
    _tagInputfield.layer.cornerRadius = 1;
    _tagInputfield.layer.borderColor = [UIColor lightGrayColor].CGColor;
    _tagInputfield.backgroundColor = [UIColor whiteColor];
  //  _tagInputfield.delegate = self;
    _tagInputfield.font = [UIFont fontWithName:@"HelveticaNeue" size:self.frame.size.height/2];//字体高度height
    _tagInputfield.placeholder = @"tag";
    _tagInputfield.autocorrectionType = UITextAutocorrectionTypeNo;
    
//    if (_mode == TLTagsControlModeEdit) {
//        [self addSubview:tagInputField_];
//    }
}

#pragma mark - layout stuff

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize contentSize = self.contentSize;
    CGRect frame = CGRectMake(0, 0, 320, self.frame.size.width);
    CGRect tempViewFrame;
    NSInteger tagIndex = 0;
    for (UIView *view in _tagSubviews) {
        tempViewFrame = view.frame;
        NSInteger index = [_tagSubviews indexOfObject:view];
        if (index != 0) {
            UIView *prevView = _tagSubviews[index - 1];
            tempViewFrame.origin.x = prevView.frame.origin.x + prevView.frame.size.width + 4;
        } else {
            tempViewFrame.origin.x = 0;
        }
        tempViewFrame.origin.y = frame.origin.y;
        view.frame = tempViewFrame;
        
//        if (_mode == TLTagsControlModeList) {
//            view.tag = tagIndex;
//            
//            UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gestureAction:)];
//            [tapRecognizer setNumberOfTapsRequired:1];
//            [tapRecognizer setDelegate:self];
//            [view setUserInteractionEnabled:YES];
//            [view addGestureRecognizer:tapRecognizer];
//        }
        
        tagIndex++;
    }
    
//    if (_mode == TLTagsControlModeEdit) {
//        frame = tagInputField_.frame;
//        frame.size.height = self.frame.size.height;
//        frame.origin.y = 0;
//        
//        if (tagSubviews_.count == 0) {
//            frame.origin.x = 7;
//        } else {
//            UIView *view = tagSubviews_.lastObject;
//            frame.origin.x = view.frame.origin.x + view.frame.size.width + 4;
//        }
//        
//        if (self.frame.size.width - tagInputField_.frame.origin.x > 100) {
//            frame.size.width = self.frame.size.width - frame.origin.x - 12;
//        } else {
//            frame.size.width = 100;
//        }
//        tagInputField_.frame = frame;
//    } else {
//        UIView *lastTag = tagSubviews_.lastObject;
//        if (lastTag != nil) {
//            frame = lastTag.frame;
//        } else {
//            frame.origin.x = 7;
//        }
//    }
    
    contentSize.width = frame.origin.x + frame.size.width;
    //
    contentSize.height = self.frame.size.height;
    
    self.contentSize = contentSize;
    
    //tagInputField_.placeholder = (_tagPlaceholder == nil) ? @"tag" : _tagPlaceholder;
}

- (void)addTag:(NSString *)tag {
    for (NSString *oldTag in _tags) {
        if ([oldTag isEqualToString:tag]) {
            return;
        }
    }
    
    [_tags addObject:tag];
    [self reloadTagSubviews];
    
    CGSize contentSize = self.contentSize;
    CGPoint offset = self.contentOffset;
    
    if (contentSize.width > self.frame.size.width) {
//        if (_mode == TLTagsControlModeEdit) {
//            offset.x = tagInputField_.frame.origin.x + tagInputField_.frame.size.width - self.frame.size.width;
//        } else {
            UIView *lastTag = _tagSubviews.lastObject;
            offset.x = lastTag.frame.origin.x + lastTag.frame.size.width - self.frame.size.width;
//        }
    } else {
        offset.x = 0;
    }
    
    self.contentOffset = offset;
}

- (void)reloadTagSubviews {
    
    for (UIView *view in _tagSubviews) {
        [view removeFromSuperview];
    }
    
    [_tagSubviews removeAllObjects];
    
    UIColor *tagBackgrounColor = _tagsBackgroundColor != nil ? _tagsBackgroundColor : [UIColor colorWithRed:0.9
                                                                                                      green:0.91
                                                                                                       blue:0.925
                                                                                                      alpha:1];
    UIColor *tagTextColor = _tagsTextColor != nil ? _tagsTextColor : [UIColor darkGrayColor];
//    UIColor *tagDeleteButtonColor = _tagsDeleteButtonColor != nil ? _tagsDeleteButtonColor : [UIColor blackColor];
    
    
    
    for (NSString *tag in _tags) {
        //3000代表textfile的可显示的字符串长度？
        float width = [tag boundingRectWithSize:CGSizeMake(3000,_tagInputfield.frame.size.height)
                                        options:NSStringDrawingUsesLineFragmentOrigin
                                     attributes:@{NSFontAttributeName:_tagInputfield.font}
                                        context:nil].size.width;
        
        UIView *tagView = [[UIView alloc] initWithFrame:_tagInputfield.frame];
        CGRect tagFrame = tagView.frame;
        tagView.layer.cornerRadius = 5;
        tagFrame.origin.y = _tagInputfield.frame.origin.y;
        tagView.backgroundColor = tagBackgrounColor;
        //每个tag是一个uilabel，内容显示的是textfile内容
        
        UILabel *tagLabel = [[UILabel alloc] init];
        CGRect labelFrame = tagLabel.frame;
        tagLabel.font = _tagInputfield.font;
        labelFrame.size.width = width ;//宽度改变影响了listtag的显示效果
        labelFrame.size.height = _tagInputfield.frame.size.height;
        tagLabel.text = tag;
        tagLabel.textColor = tagTextColor;
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.clipsToBounds = YES;
        tagLabel.layer.cornerRadius = 5;
        
//        if (_mode == TLTagsControlModeEdit) {
//            UIButton *deleteTagButton = [[UIButton alloc] initWithFrame:tagInputField_.frame];
//            CGRect buttonFrame = deleteTagButton.frame;
//            [deleteTagButton.titleLabel setFont:tagInputField_.font];
//            [deleteTagButton addTarget:self action:@selector(deleteTagButton:) forControlEvents:UIControlEventTouchUpInside];
//            buttonFrame.size.width = deleteTagButton.frame.size.height;
//            buttonFrame.size.height = tagInputField_.frame.size.height;
//            [deleteTagButton setTag:tagSubviews_.count];
//            [deleteTagButton setTitle:@"✕" forState:UIControlStateNormal];
//            [deleteTagButton setTitleColor:tagDeleteButtonColor forState:UIControlStateNormal];
//            buttonFrame.origin.y = 0;
//            buttonFrame.origin.x = labelFrame.size.width;
//            
//            deleteTagButton.frame = buttonFrame;
//            tagFrame.size.width = labelFrame.size.width + buttonFrame.size.width;
//            [tagView addSubview:deleteTagButton];
//            labelFrame.origin.x = 0;
//        } else {
            tagFrame.size.width = labelFrame.size.width + 5;
            labelFrame.origin.x = (tagFrame.size.width - labelFrame.size.width) * 0.5;
       // }
        
        [tagView addSubview:tagLabel];
        labelFrame.origin.y = 0;
        UIView *lastView = _tagSubviews.lastObject;
        
        if (lastView != nil) {
            tagFrame.origin.x = lastView.frame.origin.x + lastView.frame.size.width + 4;
        }
        
        tagLabel.frame = labelFrame;
        tagView.frame = tagFrame;
        [_tagSubviews addObject:tagView];
        [self addSubview:tagView];
    }
    
    
//    if (_mode == TLTagsControlModeEdit) {
//        if (tagInputField_.superview == nil) {
//            [self addSubview:tagInputField_];
//        }
//        CGRect frame = tagInputField_.frame;
//        if (tagSubviews_.count == 0) {
//            frame.origin.x = 7;
//        } else {
//            UIView *view = tagSubviews_.lastObject;
//            frame.origin.x = view.frame.origin.x + view.frame.size.width + 4;
//        }
//        tagInputField_.frame = frame;
//        
//    } else {
        if (_tagInputfield.superview != nil) {
            [_tagInputfield removeFromSuperview];
      //  }
    //}
    
    [self setNeedsLayout];
}

#pragma mark - buttons handlers

//- (void)deleteTagButton:(UIButton *)sender {
//    UIView *view = sender.superview;
//    [view removeFromSuperview];
//    
//    NSInteger index = [tagSubviews_ indexOfObject:view];
//    [_tags removeObjectAtIndex:index];
//    [self reloadTagSubviews];
//}
//
//- (void)tagButtonPressed:(id)sender {
//    UIButton *button = sender;
//    
//    tagInputField_.text = @"";
//    [self addTag:button.titleLabel.text];
//}

#pragma mark - textfield stuff

//- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    if (textField.text.length > 0) {
//        NSString *tag = textField.text;
//        textField.text = @"";
//        [self addTag:tag];
//    }
//    
//    return YES;
//}

//- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
//    NSString *resultingString;
//    NSString *text = textField.text;
//    
//    
//    if (string.length == 1 && [string rangeOfCharacterFromSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]].location != NSNotFound) {
//        return NO;
//    } else {
//        if (!text || [text isEqualToString:@""]) {
//            resultingString = string;
//        } else {
//            if (range.location + range.length > text.length) {
//                range.length = text.length - range.location;
//            }
//            
//            resultingString = [textField.text stringByReplacingCharactersInRange:range
//                                                                      withString:string];
//        }
//        
//        NSArray *components = [resultingString componentsSeparatedByCharactersInSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]];
//        
//        if (components.count > 2) {
//            for (NSString *component in components) {
//                if (component.length > 0 && [component rangeOfCharacterFromSet:[[NSCharacterSet alphanumericCharacterSet] invertedSet]].location == NSNotFound) {
//                    [self addTag:component];
//                    break;
//                }
//            }
//            
//            return NO;
//        }
//        
//        return YES;
//    }
}

#pragma mark - other


- (void)setTags:(NSMutableArray *)tags {
    _tags = tags;
}


@end
