/*
 * Enumerations in Java
 * Demonstrates full-featured enum classes with methods and fields
 */

// ============================================================
// HTTP STATUS ENUM (With properties and methods)
// ============================================================

enum HttpStatus {
    // Enum constants with properties
    OK(200, "OK"),
    CREATED(201, "Created"),
    NO_CONTENT(204, "No Content"),
    BAD_REQUEST(400, "Bad Request"),
    UNAUTHORIZED(401, "Unauthorized"),
    FORBIDDEN(403, "Forbidden"),
    NOT_FOUND(404, "Not Found"),
    INTERNAL_ERROR(500, "Internal Server Error"),
    BAD_GATEWAY(502, "Bad Gateway");
    
    private final int code;
    private final String message;
    
    // Constructor
    HttpStatus(int code, String message) {
        this.code = code;
        this.message = message;
    }
    
    // Methods
    public int getCode() {
        return code;
    }
    
    public String getMessage() {
        return message;
    }
    
    public boolean isSuccess() {
        return code >= 200 && code < 300;
    }
    
    public boolean isClientError() {
        return code >= 400 && code < 500;
    }
    
    public boolean isServerError() {
        return code >= 500 && code < 600;
    }
    
    @Override
    public String toString() {
        return code + " " + message;
    }
    
    // Static method to find enum by code
    public static HttpStatus fromCode(int code) {
        for (HttpStatus status : values()) {
            if (status.code == code) {
                return status;
            }
        }
        throw new IllegalArgumentException("Unknown HTTP code: " + code);
    }
}

// ============================================================
// DAY OF WEEK ENUM
// ============================================================

enum DayOfWeek {
    MONDAY("Mon", false),
    TUESDAY("Tue", false),
    WEDNESDAY("Wed", false),
    THURSDAY("Thu", false),
    FRIDAY("Fri", false),
    SATURDAY("Sat", true),
    SUNDAY("Sun", true);
    
    private final String abbreviation;
    private final boolean isWeekend;
    
    DayOfWeek(String abbreviation, boolean isWeekend) {
        this.abbreviation = abbreviation;
        this.isWeekend = isWeekend;
    }
    
    public String getAbbreviation() {
        return abbreviation;
    }
    
    public boolean isWeekend() {
        return isWeekend;
    }
    
    public DayOfWeek next() {
        DayOfWeek[] days = values();
        return days[(ordinal() + 1) % days.length];
    }
    
    public DayOfWeek previous() {
        DayOfWeek[] days = values();
        return days[(ordinal() - 1 + days.length) % days.length];
    }
}

// ============================================================
// LOG LEVEL ENUM
// ============================================================

enum LogLevel {
    DEBUG(1, "🐛"),
    INFO(2, "ℹ️"),
    WARNING(3, "⚠️"),
    ERROR(4, "❌"),
    CRITICAL(5, "🔥");
    
    private final int severity;
    private final String icon;
    
    LogLevel(int severity, String icon) {
        this.severity = severity;
        this.icon = icon;
    }
    
    public int getSeverity() {
        return severity;
    }
    
    public String getIcon() {
        return icon;
    }
    
    public boolean isAtLeast(LogLevel other) {
        return this.severity >= other.severity;
    }
}

// ============================================================
// TRAFFIC LIGHT ENUM (State Machine)
// ============================================================

enum TrafficLight {
    RED {
        @Override
        public String getAction() {
            return "STOP";
        }
        
        @Override
        public TrafficLight next() {
            return GREEN;
        }
    },
    YELLOW {
        @Override
        public String getAction() {
            return "PREPARE TO STOP";
        }
        
        @Override
        public TrafficLight next() {
            return RED;
        }
    },
    GREEN {
        @Override
        public String getAction() {
            return "GO";
        }
        
        @Override
        public TrafficLight next() {
            return YELLOW;
        }
    };
    
    // Abstract methods (must be implemented by each constant)
    public abstract String getAction();
    public abstract TrafficLight next();
}

// ============================================================
// MAIN CLASS - DEMONSTRATION
// ============================================================

public class Enums {
    public static void main(String[] args) {
        System.out.println("=== Enumerations in Java ===\n");
        
        // HTTP Status Demo
        System.out.println("--- HTTP Status Codes ---");
        HttpStatus status = HttpStatus.OK;
        System.out.println("Status: " + status);
        System.out.println("Code: " + status.getCode());
        System.out.println("Is Success: " + status.isSuccess());
        
        status = HttpStatus.NOT_FOUND;
        System.out.println("\nStatus: " + status);
        if (status.isClientError()) {
            System.out.println("✗ Client Error");
        }
        
        // Find by code
        HttpStatus found = HttpStatus.fromCode(500);
        System.out.println("Found status by code 500: " + found);
        
        // Days of Week Demo
        System.out.println("\n--- Days of Week ---");
        for (DayOfWeek day : DayOfWeek.values()) {
            System.out.printf("%s (%s)", day, day.getAbbreviation());
            if (day.isWeekend()) {
                System.out.print(" 🎉 Weekend!");
            }
            System.out.println();
        }
        
        DayOfWeek today = DayOfWeek.FRIDAY;
        System.out.println("\nToday: " + today);
        System.out.println("Tomorrow: " + today.next());
        System.out.println("Yesterday: " + today.previous());
        
        // Log Level Demo
        System.out.println("\n--- Log Levels ---");
        LogLevel currentLevel = LogLevel.WARNING;
        System.out.println("Current log level: " + currentLevel.getIcon() + " " + currentLevel);
        
        for (LogLevel level : LogLevel.values()) {
            if (level.isAtLeast(currentLevel)) {
                System.out.println(level.getIcon() + " " + level + " would be logged");
            } else {
                System.out.println("  " + level + " would be ignored");
            }
        }
        
        // Traffic Light State Machine
        System.out.println("\n--- Traffic Light State Machine ---");
        TrafficLight light = TrafficLight.RED;
        for (int i = 0; i < 5; i++) {
            System.out.println("Light: " + light + " -> Action: " + light.getAction());
            light = light.next();
        }
        
        // Enum Iteration
        System.out.println("\n--- All HTTP Statuses ---");
        for (HttpStatus s : HttpStatus.values()) {
            System.out.printf("%s (ordinal: %d)%n", s, s.ordinal());
        }
        
        // Enum in switch statement
        System.out.println("\n--- Switch Statement Demo ---");
        handleHttpStatus(HttpStatus.OK);
        handleHttpStatus(HttpStatus.NOT_FOUND);
        handleHttpStatus(HttpStatus.INTERNAL_ERROR);
        
        System.out.println("\n✓ Program completed successfully");
    }
    
    // Enum in switch statement
    private static void handleHttpStatus(HttpStatus status) {
        System.out.print("Handling " + status + ": ");
        
        switch (status) {
            case OK:
            case CREATED:
            case NO_CONTENT:
                System.out.println("✓ Success response");
                break;
            case BAD_REQUEST:
            case UNAUTHORIZED:
            case FORBIDDEN:
            case NOT_FOUND:
                System.out.println("✗ Client error");
                break;
            case INTERNAL_ERROR:
            case BAD_GATEWAY:
                System.out.println("⚠️ Server error");
                break;
            default:
                System.out.println("? Unknown status");
        }
    }
}
