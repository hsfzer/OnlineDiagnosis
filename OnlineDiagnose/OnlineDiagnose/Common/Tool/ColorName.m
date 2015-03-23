//
//  ColorName.m
//  ColorScaner
//
//  Created by wihing on 12-10-30.
//  Copyright (c) 2012年 wihing. All rights reserved.
//

#import "ColorName.h"
#import "UIKit+x.h"

@interface ColorName ()

@property (strong, nonatomic) NSArray *colorList;

@end

@implementation ColorName

+ (ColorName *)sharedInstance
{
    static ColorName *colorName;
    if (colorName == nil) {
        colorName = [[ColorName alloc] init];
    }
    return colorName;
}

+ (NSString *)nameOfColor:(UIColor *) color
{
    ColorName *colorName = [ColorName sharedInstance];
    return [colorName nameOfColor:color];
}

double RGBtoHSV(double R, double G, double B)
{
	if((R==G)&&(G==B))
	{
		return 0;
	}
	if (B<=G)
        return acos((R-G+R-B)/(2*sqrt((R-G)*(R-G)+(R-B)*(G-B)))) / (2*3.1416) ;
	else
        return 2*3.14159-acos((R-G+R-B)/(2*sqrt((R-G)*(R-G)+(R-B)*(G-B)))) / (2*3.1416)  ;
}

- (NSString *)nameOfColor:(UIColor *)color
{
    double h = RGBtoHSV(color.red, color.green, color.blue);
    NSLog(@"%f", h);
    for (int i = 0; i < self.colorList.count; i++) {
        NSArray *object = [self.colorList objectAtIndex:i];
        if ([[object objectAtIndex:2] intValue] < h) {
            continue;
        } else {
            return [object objectAtIndex:1];
        }
    }
    return @"";
}

- (id) init
{
NSArray *colorList = @[
@[@"黑色", @"Black", @0, @0, @0],
@[@"昏灰", @"Dimgray", @0, @0, @41],
@[@"灰色", @"Gray", @0, @0, @50],
@[@"暗灰", @"Dark Gray", @0, @0, @66],
@[@"银色", @"Silver", @0, @0, @75],
@[@"亮灰色", @"Light Gray", @0, @0, @83],
@[@"庚斯博罗灰", @"Gainsboro", @0, @0, @86],
@[@"白烟色", @"White Smoke", @0, @0, @96],
@[@"白色", @"White", @0, @0, @100],
@[@"雪色", @"Snow", @0, @2, @100],
@[@"沙棕", @"Sand Beige", @0, @15, @90],
@[@"玫瑰褐", @"Rosy Brown", @0, @24, @74],
@[@"亮珊瑚色", @"Light Coral", @0, @47, @94],
@[@"印度红", @"Indian Red", @0, @55, @80],
@[@"褐色", @"Brown", @0, @75, @65],
@[@"耐火砖红", @"Fire Brick", @0, @81, @70],
@[@"栗色", @"Maroon", @0, @100, @50],
@[@"暗红", @"Dark Red", @0, @100, @55],
@[@"鲜红", @"Strong Red", @0, @100, @90],
@[@"红色", @"Red", @0, @100, @100],
@[@"柿子橙", @"Persimmon", @4, @75, @100],
@[@"雾玫瑰色", @"Misty Rose", @6, @12, @100],
@[@"鲑红", @"Salmon", @6, @54, @98],
@[@"腥红", @"Scarlet", @8, @100, @100],
@[@"蕃茄红", @"Tomato", @9, @72, @100],
@[@"暗鲑红", @"Dark Salmon", @15, @48, @91],
@[@"珊瑚红", @"Coral", @16, @69, @100],
@[@"橙红", @"Orange Red", @16, @100, @100],
@[@"亮鲑红", @"Light Salmon", @17, @52, @100],
@[@"朱红", @"Vermilion", @18, @100, @100],
@[@"赭黄", @"Sienna", @19, @72, @63],
@[@"铁灰色", @"Iron Gray", @21, @12, @39],
@[@"热带橙", @"Tropical Orange", @23, @80, @100],
@[@"驼色", @"Camel", @24, @56, @63],
@[@"杏黄", @"Apricot", @24, @56, @90],
@[@"椰褐", @"Coconut Brown", @24, @100, @30],
@[@"海贝色", @"Seashell", @25, @7, @100],
@[@"鞍褐", @"Saddle Brown", @25, @86, @55],
@[@"巧克力色", @"Chocolate", @25, @86, @82],
@[@"燃橙", @"Burnt Orange", @25, @100, @80],
@[@"阳橙", @"Sun Orange", @27, @100, @100],
@[@"粉扑桃色", @"Peach Puff", @28, @27, @100],
@[@"沙褐", @"Sand Brown", @28, @61, @96],
@[@"古铜色", @"Bronze", @29, @72, @72],
@[@"亚麻色", @"Linen", @30, @8, @98],
@[@"蜜橙", @"Honey Orange", @30, @60, @100],
@[@"秘鲁色", @"Peru", @30, @69, @80],
@[@"乌贼墨色", @"Sepia", @30, @82, @44],
@[@"赭色", @"Ocher", @30, @83, @80],
@[@"陶坯黄", @"Bisque", @33, @23, @100],
@[@"橘色", @"Tangerine", @33, @100, @95],
@[@"暗橙", @"Dark Orange", @33, @100, @100],
@[@"古董白", @"Antique White", @34, @14, @98],
@[@"日晒色", @"Tan", @34, @33, @82],
@[@"硬木色", @"Burly Wood", @34, @39, @87],
@[@"杏仁白", @"Blanched Almond", @36, @20, @100],
@[@"那瓦霍白", @"Navajo White", @36, @32, @100],
@[@"万寿菊黄", @"Marigold", @36, @100, @100],
@[@"蕃木瓜色", @"Papaya Whip", @37, @16, @100],
@[@"灰土色", @"Pale Ocre", @37, @31, @80],
@[@"卡其色", @"Khaki", @37, @80, @60],
@[@"鹿皮鞋色", @"Moccasin", @38, @29, @100],
@[@"旧蕾丝色", @"Old Lace", @39, @9, @99],
@[@"小麦色", @"Wheat", @39, @27, @96],
@[@"桃色", @"Peach", @39, @29, @100],
@[@"橙色", @"Orange", @39, @100, @100],
@[@"花卉白", @"Floral White", @40, @6, @100],
@[@"金菊色", @"Goldenrod", @43, @85, @85],
@[@"暗金菊色", @"Dark Goldenrod", @43, @94, @72],
@[@"咖啡色", @"Coffee", @44, @100, @30],
@[@"茉莉黄", @"Jasmine", @45, @60, @90],
@[@"琥珀色", @"Amber", @45, @100, @100],
@[@"玉米丝色", @"Cornsilk", @48, @14, @100],
@[@"铬黄", @"Chrome Yellow", @48, @100, @90],
@[@"金色", @"Golden", @51, @100, @100],
@[@"柠檬绸色", @"Lemon Chiffon", @54, @20, @100],
@[@"亮卡其色", @"Light Khaki", @54, @42, @94],
@[@"灰金菊色", @"Pale Goldenrod", @55, @29, @93],
@[@"暗卡其色", @"Dark Khaki", @56, @43, @74],
@[@"含羞草黄", @"Mimosa", @56, @78, @90],
@[@"奶油色", @"Cream", @57, @18, @100],
@[@"象牙色", @"Ivory", @60, @6, @100],
@[@"米黄色", @"Beige", @60, @10, @96],
@[@"亮黄", @"Light Yellow", @60, @12, @100],
@[@"亮金菊黄", @"Light Goldenrod Yellow", @60, @16, @98],
@[@"香槟黄", @"Champagne Yellow", @60, @40, @100],
@[@"芥末黄", @"Mustard", @60, @62, @80],
@[@"月黄", @"Moon Yellow", @60, @70, @100],
@[@"橄榄色", @"Olive", @60, @100, @50],
@[@"鲜黄", @"Canary Yellow", @60, @100, @100],
@[@"黄色", @"Yellow", @60, @100, @100],
@[@"苔藓绿", @"Moss Green", @70, @71, @47],
@[@"亮柠檬绿", @"Light Lime", @72, @100, @100],
@[@"橄榄军服绿", @"Olive Drab", @80, @75, @56],
@[@"黄绿", @"Yellow Green", @80, @76, @80],
@[@"暗橄榄绿", @"Dark Olive Green", @82, @56, @42],
@[@"苹果绿", @"Apple Green", @83, @100, @90],
@[@"绿黄", @"Green Yellow", @84, @82, @100],
@[@"草绿", @"Grass Green", @90, @67, @90],
@[@"草坪绿", @"Lawn Green", @90, @100, @99],
@[@"查特酒绿", @"Chartreuse", @90, @100, @100],
@[@"叶绿", @"Foliage Green", @93, @69, @72],
@[@"嫩绿", @"Fresh Leaves", @94, @70, @100],
@[@"明绿", @"Bright Green", @96, @100, @100],
@[@"钴绿", @"Cobalt Green", @115, @65, @100],
@[@"蜜瓜绿", @"Honeydew", @120, @6, @100],
@[@"暗海绿", @"Dark Sea Green", @120, @24, @74],
@[@"亮绿", @"Light Green", @120, @39, @93],
@[@"灰绿", @"Pale Green", @120, @39, @98],
@[@"常春藤绿", @"Ivy Green", @120, @72, @75],
@[@"森林绿", @"Forest Green", @120, @76, @55],
@[@"柠檬绿", @"Lime Green", @120, @76, @80],
@[@"暗绿", @"Dark Green", @120, @100, @39],
@[@"绿色", @"Green", @120, @100, @50],
@[@"鲜绿色", @"Lime", @120, @100, @100],
@[@"孔雀石绿", @"Malachite", @124, @83, @76],
@[@"薄荷绿", @"Mint", @130, @86, @60],
@[@"青瓷绿", @"Celadon Green", @133, @50, @90],
@[@"碧绿", @"Emerald", @140, @60, @78],
@[@"绿松石绿", @"Turquoise Green", @140, @67, @90],
@[@"铬绿", @"Veridian", @142, @84, @45],
@[@"苍色", @"Horizon Blue", @146, @35, @100],
@[@"海绿", @"Sea Green", @146, @67, @55],
@[@"中海绿", @"Medium Sea Green", @147, @66, @70],
@[@"薄荷奶油色", @"Mint Cream", @150, @4, @100],
@[@"春绿", @"Spring Green", @150, @100, @100],
@[@"孔雀绿", @"Peacock Green", @154, @100, @63],
@[@"中春绿色", @"Medium Spring Green", @157, @100, @98],
@[@"中碧蓝色", @"Medium Aquamarine", @160, @50, @80],
@[@"碧蓝色", @"Aquamarine", @160, @50, @100],
@[@"青蓝", @"Cyan Blue", @163, @93, @75],
@[@"水蓝", @"Aqua Blue", @170, @60, @100],
@[@"绿松石蓝", @"Turquoise Blue", @171, @78, @90],
@[@"绿松石色", @"Turquoise", @175, @77, @84],
@[@"亮\346\265\267绿", @"Light Sea Green", @177, @82, @70],
@[@"中绿松石色", @"Medium Turquoise", @178, @66, @82],
@[@"亮青", @"Light Cyan", @180, @12, @100],
@[@"浅蓝", @"Baby Blue", @180, @12, @100],
@[@"灰绿松石色", @"Pale Turquoise", @180, @26, @93],
@[@"暗岩灰", @"Dark Slate Gray", @180, @41, @31],
@[@"凫绿", @"Teal", @180, @100, @50],
@[@"暗青", @"Dark Cyan", @180, @100, @55],
@[@"青色", @"Cyan", @180, @100, @100],
@[@"暗绿松石色", @"Dark Turquoise", @181, @100, @82],
@[@"军服蓝", @"Cadet Blue", @182, @41, @63],
@[@"孔雀蓝", @"Peacock Blue", @185, @100, @55],
@[@"水色", @"Aqua", @186, @23, @89],
@[@"婴儿粉蓝", @"Powder Blue", @187, @23, @90],
@[@"浓蓝", @"Strong Blue", @189, @100, @45],
@[@"亮蓝", @"Light Blue", @195, @25, @90],
@[@"灰蓝", @"Pale Blue", @195, @40, @80],
@[@"萨克斯蓝", @"Saxe Blue", @195, @60, @70],
@[@"深天蓝", @"Deep Sky Blue", @195, @100, @100],
@[@"天蓝", @"Sky Blue", @197, @43, @92],
@[@"亮天蓝", @"Light Sky Blue", @203, @46, @98],
@[@"普\351\262\201士蓝", @"Prussian blue", @205, @100, @43],
@[@"水手蓝", @"Marine Blue", @206, @100, @49],
@[@"钢青色", @"Steel Blue", @207, @61, @71],
@[@"爱丽丝蓝", @"Alice Blue", @208, @6, @100],
@[@"岩灰", @"Slate Gray", @210, @22, @56],
@[@"亮岩灰", @"Light Slate Gray", @210, @22, @60],
@[@"道奇蓝", @"Dodger Blue", @210, @88, @100],
@[@"矿蓝", @"Mineral Blue", @210, @100, @60],
@[@"湛蓝", @"Azure", @210, @100, @100],
@[@"韦奇伍德瓷蓝", @"Wedgwood Blue", @213, @55, @75],
@[@"亮钢蓝", @"Light Steel Blue", @214, @21, @87],
@[@"钴蓝", @"Cobalt Blue", @215, @100, @67],
@[@"灰丁宁蓝", @"Pale Denim", @216, @51, @76],
@[@"矢车菊蓝", @"Cornflower Blue", @219, @58, @93],
@[@"鼠尾草蓝", @"Salvia Blue", @220, @67, @90],
@[@"暗婴儿粉蓝", @"Dark Powder Blue", @220, @100, @60],
@[@"蓝宝石色", @"Sapphire", @222, @92, @40],
@[@"国际奇连蓝", @"International Klein Blue", @223, @100, @65],
@[@"蔚蓝", @"Cerulean blue", @224, @78, @75],
@[@"品蓝", @"Royal Blue", @225, @71, @88],
@[@"暗矿蓝", @"Dark Mineral Blue", @228, @71, @49],
@[@"极浓海蓝", @"Ultramarine", @228, @100, @100],
@[@"天青石蓝", @"Lapis Lazuli", @231, @95, @100],
@[@"幽灵白", @"Ghost White", @240, @3, @100],
@[@"薰衣草紫", @"Lavender", @240, @8, @98],
@[@"长春花色", @"Periwinkle", @240, @20, @100],
@[@"午夜蓝", @"Midnight Blue", @240, @78, @44],
@[@"藏青", @"Navy Blue", @240, @100, @50],
@[@"暗蓝", @"Dark Blue", @240, @100, @55],
@[@"中蓝", @"Medium Blue", @240, @100, @80],
@[@"蓝色", @"Blue", @240, @100, @100],
@[@"紫藤色", @"Wisteria", @245, @65, @90],
@[@"暗岩蓝", @"Dark Slate Blue", @248, @56, @55],
@[@"岩蓝", @"Slate Blue", @248, @56, @80],
@[@"中岩蓝", @"Medium Slate Blue", @249, @56, @93],
@[@"木槿紫", @"Mauve", @252, @75, @100],
@[@"紫丁香色", @"Lilac", @255, @40, @100],
@[@"中紫红", @"Medium Purple", @260, @49, @86],
@[@"紫水晶色", @"Amethyst", @260, @75, @80],
@[@"浅灰紫红", @"Grayish Purple", @264, @28, @63],
@[@"缬草紫", @"Heliotrope", @266, @100, @72],
@[@"矿紫", @"Mineral Violet", @270, @22, @81],
@[@"蓝紫", @"Blue Violet", @271, @81, @89],
@[@"紫罗兰色", @"Violet", @273, @100, @100],
@[@"靛色", @"Indigo", @275, @100, @50],
@[@"暗兰紫", @"Dark Orchid", @280, @75, @80],
@[@"暗紫", @"Dark Violet", @282, @100, @83],
@[@"三色堇紫", @"Pansy", @283, @100, @63],
@[@"锦葵紫", @"Mallow", @287, @70, @100],
@[@"优品紫红", @"Opera Mauve", @288, @50, @100],
@[@"中兰紫", @"Medium Orchid", @288, @60, @83],
@[@"淡紫丁香色", @"Pail Lilac", @300, @10, @90],
@[@"蓟紫", @"Thistle", @300, @12, @85],
@[@"铁线莲紫", @"Clematis", @300, @20, @80],
@[@"梅红色", @"Plum", @300, @28, @87],
@[@"亮紫", @"Light Violet", @300, @45, @93],
@[@"紫色", @"Purple", @300, @100, @50],
@[@"暗洋红", @"Dark Magenta", @300, @100, @55],
@[@"洋红", @"Magenta", @300, @100, @100],
@[@"兰紫", @"Orchid", @302, @49, @85],
@[@"浅珍珠红", @"Pearl Pink", @320, @30, @100],
@[@"陈玫红", @"Old Rose", @320, @53, @72],
@[@"浅玫瑰红", @"Rose Pink", @320, @60, @100],
@[@"品红", @"Fuchsia", @320, @100, @96],
@[@"中青紫红", @"Medium Violet Red", @322, @89, @78],
@[@"洋玫瑰红", @"Magenta Rose", @322, @95, @100],
@[@"红宝石色", @"Ruby", @322, @100, @80],
@[@"山茶红", @"Camellia", @328, @75, @90],
@[@"深粉红", @"Deep Pink", @328, @92, @100],
@[@"火鹤红", @"Flamingo", @330, @40, @90],
@[@"浅珊瑚红", @"Coral Pink", @330, @50, @100],
@[@"暖粉红", @"Hot Pink", @330, @59, @100],
@[@"勃艮第酒红", @"Burgundy", @330, @100, @28],
@[@"玫瑰红", @"Rose", @330, @100, @100],
@[@"尖晶石红", @"Spinel Red", @333, @55, @100],
@[@"胭脂红", @"Carmine", @336, @100, @90],
@[@"浅粉红", @"Baby Pink", @339, @15, @100],
@[@"枢机红", @"Cardinal Red", @339, @100, @60],
@[@"薰衣草紫红", @"Lavender Blush", @340, @6, @100],
@[@"灰紫红", @"Pale Violet Red", @340, @49, @86],
@[@"樱桃红", @"Cerise", @343, @78, @87],
@[@"浅鲑红", @"Salmon Pink", @348, @50, @100],
@[@"绯红", @"Crimson", @348, @91, @86],
@[@"粉红", @"Pink", @350, @25, @100],
@[@"亮粉红", @"Light Pink", @351, @29, @100],
@[@"壳黄红", @"Shell Pink", @351, @30, @100],
@[@"茜红", @"Alizarin Crimson", @355, @83, @89]
];
    _colorList = colorList;
    return self;
}
@end
