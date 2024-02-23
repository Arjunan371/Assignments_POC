//
//  TimeDateClass.swift
//  Assignments_POC
//
//  Created by Arjunan on 14/11/23.
//
import Foundation

class DateManager {

    let dateFormatter = DateFormatter()
    
    static let shared = DateManager()
    private init() {
        dateFormatter.locale = Locale(identifier: "en")
    }
    
    func convertDate(_ dateStr: String, from: String) -> Date? {
        dateFormatter.dateFormat = from
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.timeZone = TimeZone.current
        guard let date = dateFormatter.date(from: dateStr) else {
            return nil
        }
        return date

    }
    
    func convertDate(_ dateStr: String, from: String, to: String) -> String {
        dateFormatter.dateFormat = from //from"MMM dd, yyyy"
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.timeZone = TimeZone.current
        guard let date = dateFormatter.date(from: dateStr) else {
            return ""
        }
        dateFormatter.dateFormat = to//"yyyy-MM-dd"
        return  dateFormatter.string(from: date)

    }
    
    func convertTime(_ timeStr: String, from: String, to: String) -> String {
        dateFormatter.dateFormat = from//"h:mm a"
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.timeZone = TimeZone.current
        guard let date = dateFormatter.date(from: timeStr) else {
            return ""
        }
        dateFormatter.dateFormat = to//"HH:mm:ss"
        //dateFormatter.amSymbol = ""
        //dateFormatter.pmSymbol = "p"
        return  dateFormatter.string(from: date)

    }
    
    func gregorianDate(dateStr: String, format:String) -> String {
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.timeZone = TimeZone.current
        guard let fromDate = dateFormatter.date(from: dateStr) else {
            return ""
        }
       
        dateFormatter.dateFormat = format//"MMMM yyyy"
        let toStr = dateFormatter.string(from: fromDate)
        
        return toStr
    }
    
    func islamicDate(dateStr: String, format:String) -> String {
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.timeZone = TimeZone.current
        guard let fromDate = dateFormatter.date(from: dateStr) else {
            return ""
        }
        dateFormatter.dateFormat = format//"MMMM yyyy"
        dateFormatter.calendar = Calendar(identifier: .islamicUmmAlQura)
        let toStr = dateFormatter.string(from: fromDate)
        return toStr
    }
    
    func utcToLocal(_ dateStr: String ,from: String, to: String) -> String {
      
        dateFormatter.dateFormat = from
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        guard let date = dateFormatter.date(from: dateStr) else {
            return ""
        }
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = to

      return dateFormatter.string(from: date)
    }

    func localToUTC(_ dateStr: String ,from: String, to: String) -> String {
      
        dateFormatter.dateFormat = from
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.timeZone = TimeZone.current

        guard let date = dateFormatter.date(from: dateStr) else {
            return ""
        }
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        dateFormatter.dateFormat = to

        return dateFormatter.string(from: date)
    }
    
    func getDateOrder(startDateStr: String, endDateStr: String) -> ComparisonResult {
        
        //let toDateStr = utcToLocal(dateStr, from: "yyyy-MM-dd HH:mm:ss", to: "yyyy-MM-dd HH:mm:ss")
        
        let formatter = dateFormatter
        formatter.timeZone = .current
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        let now = formatter.string(from: Date())
        guard let currDate = formatter.date(from: now), let startDate = formatter.date(from: startDateStr), let endDate = formatter.date(from: endDateStr) else {
            return .orderedDescending
        }
        
        if currDate < startDate {
            return .orderedAscending
        } else if currDate > endDate {
            return .orderedDescending
        } else {
            return .orderedSame
        }
    }
    
    func getDateTimeDiff(dateStr:String) -> String {
        
        let toDateStr = utcToLocal(dateStr, from: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'", to: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
        
        let formatter = dateFormatter
        formatter.timeZone = NSTimeZone.local
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"

        let now = formatter.string(from: Date())
        let startDate = formatter.date(from: toDateStr)
        let endDate = formatter.date(from: now)

        // *** create calendar object ***
        var calendar = NSCalendar.current
        
        // *** Get components using current Local & Timezone ***
 //       log(calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: startDate!))
        
        // *** define calendar components to use as well Timezone to UTC ***
        let unitFlags = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second])
        calendar.timeZone = NSTimeZone.local
        let dateComponents = calendar.dateComponents(unitFlags, from: startDate!, to: endDate!)
         // *** Get Individual components from date ***
        let years = dateComponents.year!
        let months = dateComponents.month!
        let days = dateComponents.day!
        let hours = dateComponents.hour!
        let minutes = dateComponents.minute!
        let seconds = dateComponents.second!
        
        var timeAgo = ""
        
        if (seconds > 0) {
            
            timeAgo = "\(seconds)s"
        }

        if (minutes > 0) {
            
            timeAgo = "\(minutes)m"
        }

        if(hours > 0) {
            
            timeAgo = "\(hours)h"
        }

        if (days > 0) {
            
            timeAgo = "\(days)d"
        }
        if (days >= 7) {
            
            timeAgo = "\(days/7)w"
        }
        if(months > 0) {
            timeAgo = "\(convertDate("\(months-days)", from: "MM-d", to: "d MMM"))"
        }

        if(years > 0) {
            
            timeAgo = "\(years)y"
        }
        if(seconds < 0 || minutes < 0 || hours < 0 || days < 0 || months < 0 || years < 0) {
            timeAgo = "Future"
        }
        return timeAgo
    }

    func timeToGo(_ dateStr:String,_ isBefore: Bool,_ isShort: Bool ) -> String {
        
        //let toDateStr = utcToLocal(dateStr, from: "yyyy-MM-dd HH:mm:ss", to: "yyyy-MM-dd HH:mm:ss")
        
        let formatter = dateFormatter
        formatter.timeZone = .current
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        
        let now = formatter.string(from: Date())
        guard let startDate = formatter.date(from: dateStr), let endDate = formatter.date(from: now) else {
            return ""
        }
        
        // *** create calendar object ***
        var calendar = NSCalendar.current
        
        // *** Get components using current Local & Timezone ***
         
        // *** define calendar components to use as well Timezone to UTC ***
        let unitFlags = Set<Calendar.Component>([.year, .month, .day, .hour, .minute, .second])
        calendar.timeZone = NSTimeZone.local
        let dateComponents: DateComponents// = calendar.dateComponents(unitFlags, from: startDate, to: endDate)
        
        if isBefore {
            dateComponents = calendar.dateComponents(unitFlags, from: endDate, to: startDate)
        } else {
            
            dateComponents = calendar.dateComponents(unitFlags, from: startDate, to: endDate)
        }
        // *** Get Individual components from date ***
        let years = dateComponents.year ?? 0
        let months = dateComponents.month ?? 0
        let days = dateComponents.day ?? 0
        let hours = dateComponents.hour ?? 0
        let minutes = dateComponents.minute ?? 0
        let seconds = dateComponents.second ?? 0
        
        var timeAgo = ""
        
        if (seconds > 0) {
            
            timeAgo = "\(seconds)\(isShort ? "s" : " Secs")"
        }
        
        if (minutes > 0) {
            
            timeAgo = "\(minutes)\(isShort ? "m" : " Mins")"
        }

        if(hours > 0) {
            
            timeAgo = "\(hours)\(isShort ? "h" : " Hours")"
        }
        
        if (days > 0) {
            
            timeAgo = "\(days)\(isShort ? "d" : " Days")"
        }
        if (days >= 7) {
            
            timeAgo = "\(days/7)\(isShort ? "w" : " Weeks")"
        }
        if(months > 0) {
            timeAgo = "\(convertDate("\(months)-\(days)", from: "MM-d", to: "d MMM"))"
        }
        
        if(years > 0) {
            
            timeAgo = "\(years)\(isShort ? "y" : " Years")"
        }
        if(seconds < 0 || minutes < 0 || hours < 0 || days < 0 || months < 0 || years < 0) {
            timeAgo = isBefore ? "Past" : "Future"
        }
        
        return timeAgo
    }
    
    func getTimeDuration(_ fromTime:String,_ toTime:String, _ format: String,_ isShort: Bool ) -> String {
        
        //let toDateStr = utcToLocal(dateStr, from: "yyyy-MM-dd HH:mm:ss", to: "yyyy-MM-dd HH:mm:ss")
        
        let formatter = dateFormatter
        formatter.timeZone = .current
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        
        guard let startDate = formatter.date(from: fromTime), let endDate = formatter.date(from: toTime) else {
            return ""
        }
        
        // *** create calendar object ***
        var calendar = NSCalendar.current
        
        // *** Get components using current Local & Timezone ***
         // *** define calendar components to use as well Timezone to UTC ***
        let unitFlags = Set<Calendar.Component>([.hour, .minute, .second])
        calendar.timeZone = NSTimeZone.local
        let dateComponents: DateComponents// = calendar.dateComponents(unitFlags, from: startDate, to: endDate)
        dateComponents = calendar.dateComponents(unitFlags, from: startDate, to: endDate)
        /*
        if isBefore {
            dateComponents = calendar.dateComponents(unitFlags, from: endDate, to: startDate)
        } else {
            
            dateComponents = calendar.dateComponents(unitFlags, from: startDate, to: endDate)
        }
 */
         // *** Get Individual components from date ***
        
        let hours = dateComponents.hour ?? 0
        let minutes = dateComponents.minute ?? 0
        let seconds = dateComponents.second ?? 0
        
        var timeDiff = ""
        
        if(hours > 0) {
            timeDiff += "\(hours)\(isShort ? "h" : (hours == 1 ? " Hour": " Hours"))"
        }
        
        if (minutes > 0) {
            if timeDiff.isEmpty {
                timeDiff += "\(minutes)\(isShort ? "m" : (minutes == 1 ? " Min": " Mins"))"
            } else {
                timeDiff += " \(minutes)\(isShort ? "m" : (minutes == 1 ? " Min": " Mins"))"
            }
            
        }
        
        if (seconds > 0) {
            if timeDiff.isEmpty {
                timeDiff += "\(seconds)\(isShort ? "s" : (seconds == 1 ? " Sec": " Secs"))"
            } else {
                timeDiff += " \(seconds)\(isShort ? "s" : (seconds == 1 ? " Sec": " Secs"))"
            }
            
        }
        return timeDiff
    }
    func compareDate(_ dateStr: String, _ format: String) -> String {
        
        //let toDateStr = utcToLocal(dateStr, from: "yyyy-MM-dd HH:mm:ss", to: "yyyy-MM-dd HH:mm:ss")
        
        let formatter = dateFormatter
        formatter.timeZone = .current
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        
        guard let startDate = formatter.date(from: dateStr)else {
            return ""
        }
        
        var timeDiff = ""
        
        if Calendar.current.isDateInToday(startDate) {
            
            timeDiff = "Today"
        } else if Calendar.current.isDateInTomorrow(startDate) {
            
            timeDiff = "Tomorrow"
        } else if Calendar.current.isDateInYesterday(startDate) {
            
            timeDiff = "Yesterday"
        } else {
            formatter.dateFormat = "dd MMM yyyy"
            timeDiff = formatter.string(from: startDate)
        }
        
        return timeDiff
    }
    func getChannelUpdateTime(updatedAt: Date) -> String {
        
        let formatter = dateFormatter
        formatter.timeZone = NSTimeZone.local
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let secondsAgo = Int(Date().timeIntervalSince(updatedAt))
        /*
        let minutes = 60
        let hours = 60 * minutes
        let days = 24 * hours
        let weeks = 7 * days
        */
        let calendar = NSCalendar.current
        if secondsAgo <= 0 {
            formatter.dateFormat = "h:mm a"
            return formatter.string(from: Date())
        } else if calendar.isDateInToday(updatedAt) {
            formatter.dateFormat = "h:mm a"
            return formatter.string(from: updatedAt)
        } else if calendar.isDateInYesterday(updatedAt) {
            return "Yesterday"
        } /* else if secondsAgo < weeks {
            formatter.dateFormat = "EEEE"
            return formatter.string(from: updatedAt)
        }*/ else {
            formatter.dateFormat = "dd MMM yyyy"
            return formatter.string(from: updatedAt)
        }

    }
    func getChatHeaderDate(date: Date) -> String {
        
        let formatter = dateFormatter
        formatter.timeZone = NSTimeZone.local
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)

       // let secondsAgo = Int(Date().timeIntervalSince(date))
        
//        let minutes = 60
//        let hours = 60 * minutes
//        let days = 24 * hours
        //let weeks = 7 * days
        
        //let calendar = NSCalendar.current
        /* if secondsAgo <= 0 {
         return "future"
         }  else if calendar.isDateInToday(date) {
         return "Today"
         } else if calendar.isDateInYesterday(date) {
         return "Yesterday"
         }  else if secondsAgo < weeks {
         formatter.dateFormat = "EEEE"
         return formatter.string(from: date)
         }  else {
         }*/
    }
    func getChatTime(date: Date) -> String {
        
        let formatter = dateFormatter
        formatter.timeZone = NSTimeZone.local
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = "h:mm a"
        return formatter.string(from: date)
    }
}
