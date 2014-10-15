//
//  ARButtonSubclassTests.m
//  ARButtonSubclassTests.m
//
//  Created by Laura Brown on 9/23/14.
//  Copyright (c) 2014 Laura Brown. All rights reserved.
//

#import <Artsy-UIButtons/ARButtonSubclasses.h>

SpecBegin(ARButtonSubclasses)

sharedExamplesFor(@"ar button", ^(NSDictionary *data) {
    ARButton *button = data[@"button"];
    beforeAll(^{
        [button setTitle:@"Button Title" forState:UIControlStateNormal];
    });

    after(^{
        [button setEnabled:YES animated:NO];
        button.highlighted = NO;
        button.selected = NO;
    });

    it(@"normal", ^{
        expect(button).to.haveValidSnapshot();
    });

    it(@"disabled", ^{
        [button setEnabled:NO animated:NO];
        expect(button).to.haveValidSnapshot();
    });
});

describe(@"ARButton", ^{
    ARButton *button = [[ARButton alloc] initWithFrame:CGRectMake(0, 0, 300, 46)];
    button.backgroundColor = [UIColor blackColor];
    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];

    itBehavesLike(@"ar button", @{@"button": button});
});

describe(@"ARUppercaseButton", ^{
    it(@"capitalizes title", ^{
        ARUppercaseButton *button = [[ARUppercaseButton alloc] initWithFrame:CGRectMake(0, 0, 300, 46)];
        [button setTitle:@"Button Title" forState:UIControlStateNormal];
        expect(button.titleLabel.text).to.equal(@"BUTTON TITLE");
    });
});

describe(@"ARNavigationTabButton", ^{
    ARNavigationTabButton *button = [[ARNavigationTabButton alloc] initWithFrame:CGRectMake(0, 0, 300, 46)];
    itBehavesLike(@"ar button", @{@"button": button});

    it(@"selected", ^{
        button.selected = YES;
        expect(button).to.haveValidSnapshot();
    });
});

describe(@"ARModalMenuButton", ^{
    ARModalMenuButton *button = [[ARModalMenuButton alloc] initWithFrame:CGRectMake(0, 0, 300, 46)];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    itBehavesLike(@"ar button", @{@"button": button});
});

describe(@"ARInquireButton", ^{
    ARInquireButton *button = [[ARInquireButton alloc] initWithFrame:CGRectMake(0, 0, 300, 24)];
    itBehavesLike(@"ar button", @{@"button": button});
});

// ARFlatButton subclass snapshots

sharedExamplesFor(@"flat button", ^(NSDictionary *data) {
    ARFlatButton *button = data[@"button"];
    beforeAll(^{
        [button setTitle:@"Button Title" forState:UIControlStateNormal];
    });

    after(^{
        [button setEnabled:YES animated:NO];
        [button setHighlighted:NO animated:YES];;
        [button setSelected:NO animated:NO];
    });

    it(@"normal", ^{
        expect(button).to.haveValidSnapshot();
    });

    it(@"disabled", ^{
        [button setEnabled:NO animated:NO];
        expect(button).to.haveValidSnapshot();
    });

    it(@"highlighted", ^{
        [button setHighlighted:YES animated:NO];;
        expect(button).to.haveValidSnapshot();
    });
});

describe(@"ARMenuButton", ^{
    ARMenuButton *button = [[ARMenuButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    itBehavesLike(@"flat button", @{@"button": button});
});

describe(@"ARClearFlatButton", ^{
    ARButton *button = [[ARClearFlatButton alloc] initWithFrame:CGRectMake(0, 0, 300, 46)];
    itBehavesLike(@"flat button", @{@"button": button});
});

describe(@"ARWhiteFlatButton", ^{
    ARButton *button = [[ARWhiteFlatButton alloc] initWithFrame:CGRectMake(0, 0, 300, 46)];
    itBehavesLike(@"flat button", @{@"button": button});
});

describe(@"ARBlackFlatButton", ^{
    ARButton *button = [[ARBlackFlatButton alloc] initWithFrame:CGRectMake(0, 0, 300, 46)];
    itBehavesLike(@"flat button", @{@"button": button});
});

describe(@"ARHeroUnitButton", ^{
    ARHeroUnitButton *button = [[ARHeroUnitButton alloc] initWithFrame:CGRectMake(0, 0, 300, 46)];
    [button setColor:[UIColor yellowColor] animated:NO];
    [button setInverseColor:[UIColor blackColor]];
    itBehavesLike(@"flat button", @{@"button": button});
});

SpecEnd
