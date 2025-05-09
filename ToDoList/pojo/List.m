//
//  List.m
//  ToDoList
//
//  Created by Nermeen Mohamed on 07/05/2025.
//

#import "List.h"

@implementation List

- (void)setName:(NSString *)name desc:(NSString *)desc priority:(NSInteger)priority date:(NSDate *)date notify:(BOOL)notify status:(NSInteger)status notifyId:(NSString*) str{
    self.name = name;
    self.desc = desc;
    self.priority = priority;
    self.date = date;
    self.notify = notify;
    self.status = status;
    self.notifyID = str;
}


- (void)encodeWithCoder:(nonnull NSCoder *)coder {
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_notifyID forKey:@"notifyId"];
    [coder encodeObject:_desc forKey:@"desc"];
    [coder encodeObject:_savedFileName forKey:@"fileName"];
    [coder encodeObject:_savedFileURL forKey:@"fileURL"];
    [coder encodeInteger:_priority forKey:@"priority"];
    [coder encodeObject:_date forKey:@"date"];
    [coder encodeBool:_notify forKey:@"notify"];
    [coder encodeInteger:_status forKey:@"status"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)coder {
    if ((self = [super init])) {
        _name = [coder decodeObjectOfClass:[NSString class] forKey:@"name"];
        _notifyID = [coder decodeObjectOfClass:[NSString class] forKey:@"notifyId"];
        _desc = [coder decodeObjectOfClass:[NSString class] forKey:@"desc"];
        _savedFileName = [coder decodeObjectOfClass:[NSString class] forKey:@"fileName"];
        _savedFileURL = [coder decodeObjectOfClass:[NSURL class] forKey:@"fileURL"];
        _priority = [coder decodeIntegerForKey:@"priority"];
        _date = [coder decodeObjectOfClass:[NSDate class] forKey:@"date"];
        _notify = [coder decodeBoolForKey:@"notify"];
        _status = [coder decodeIntegerForKey:@"status"];
    }
    return self;
}

+ (BOOL)supportsSecureCoding {
    return YES;
}

- (id)copyWithZone:(NSZone *)zone {
    List *copy = [[[self class] allocWithZone:zone] init];
    copy.name = [self.name copy];
    copy.desc = [self.desc copy];
    copy.priority = self.priority;
    copy.date = [self.date copy];
    copy.notify = self.notify;
    copy.status = self.status;
    return copy;
}
- (BOOL)isEqual:(id)object {
    if (self == object) {
        return YES;
    }

    if (![object isKindOfClass:[List class]]) {
        return NO;
    }

    List *other = (List *)object;
    return [self.taskID isEqualToString:other.taskID];
}

- (NSUInteger)hash {
    return [self.taskID hash];
}


@end

