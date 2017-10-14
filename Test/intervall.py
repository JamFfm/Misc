#!/usr/bin/env python
# -*- coding: iso-8859-15 -*-

import datetime


def zeitspanne(sekunden):
#    """
#    Gibt die Zeitspanne als Tuppel zurück
#    
#    @return: (wochen, tage, stunden, minuten, sekunden)
#    """   
    delta = datetime.timedelta(seconds = sekunden)
    delta_str = str(delta)[-8:] # z.B: " 1:01:01"
    hours, minutes, seconds = [ int(val) for val in delta_str.split(":", 3) ]
    weeks = delta.days // 7
    days = delta.days % 7
    
    return weeks, days, hours, minutes, seconds


def zeitspanne_variante2(seconds):
#    """
#    Gibt die Zeitspanne als Tuppel zurück
#    
#    @return: (wochen, tage, stunden, minuten, sekunden)
#    """
    WEEK = 60 * 60 * 24 * 7
    DAY = 60 * 60 * 24
    HOUR = 60 * 60
    MINUTE = 60

    weeks = seconds // WEEK
    seconds = seconds % WEEK
    days = seconds // DAY
    seconds = seconds % DAY
    hours = seconds // HOUR
    seconds = seconds % HOUR
    minutes = seconds // MINUTE
    seconds = seconds % MINUTE

    #return weeks, days, hours, minutes, seconds
    if weeks >= 1:
        remaining_time = (u"W%d D%d %02d:%02d" % (int(weeks), int(days), int(hours), int(minutes)))
        return ((u"%s %s" % (("Gaerbottich").ljust(8)[:7],remaining_time))[:20])
    elif weeks == 0 and days >= 1:
        remaining_time = (u"D%d %02d:%02d:%02d" % (int(days), int(hours), int(minutes), int(seconds)))
        return ((u"%s %s" % (("Gaerbottich").ljust(8)[:7],remaining_time))[:20])
    elif weeks == 0 and days == 0:
        remaining_time = (u"%02d:%02d:%02d" % (int(hours), int(minutes), int(seconds)))
        return ((u"%s %s" % (("Gaerbottich").ljust(11)[:10],remaining_time))[:20])
    else:
        pass
    pass
#line2 = ((u"%s %s" % ((value.name).ljust(8)[:7],ftime_remaining))[:20])
    

def main():
    print zeitspanne(1434567)
    print zeitspanne_variante2(1434567)
    print zeitspanne(604800)
    print zeitspanne_variante2(604800)
    print zeitspanne(604799)
    print zeitspanne_variante2(604799)
    print zeitspanne(12000)
    print zeitspanne_variante2(12000)
    print zeitspanne(180)
    print zeitspanne_variante2(180)
    
if __name__ == "__main__":
    main()
