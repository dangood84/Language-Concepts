/*
 * Enumerations in C
 * Demonstrates simple integer-based enums
 */

#include <stdio.h>
#include <string.h>

// ============================================================
// HTTP STATUS CODE ENUMS
// ============================================================

enum HttpStatus {
    HTTP_OK = 200,
    HTTP_CREATED = 201,
    HTTP_NO_CONTENT = 204,
    HTTP_BAD_REQUEST = 400,
    HTTP_UNAUTHORIZED = 401,
    HTTP_FORBIDDEN = 403,
    HTTP_NOT_FOUND = 404,
    HTTP_INTERNAL_ERROR = 500,
    HTTP_BAD_GATEWAY = 502
};

// Enum to string conversion
const char* http_status_to_string(enum HttpStatus status) {
    switch (status) {
        case HTTP_OK: return "200 OK";
        case HTTP_CREATED: return "201 Created";
        case HTTP_NO_CONTENT: return "204 No Content";
        case HTTP_BAD_REQUEST: return "400 Bad Request";
        case HTTP_UNAUTHORIZED: return "401 Unauthorized";
        case HTTP_FORBIDDEN: return "403 Forbidden";
        case HTTP_NOT_FOUND: return "404 Not Found";
        case HTTP_INTERNAL_ERROR: return "500 Internal Server Error";
        case HTTP_BAD_GATEWAY: return "502 Bad Gateway";
        default: return "Unknown Status";
    }
}

// ============================================================
// DAYS OF WEEK ENUM
// ============================================================

enum DayOfWeek {
    MONDAY,      // 0
    TUESDAY,     // 1
    WEDNESDAY,   // 2
    THURSDAY,    // 3
    FRIDAY,      // 4
    SATURDAY,    // 5
    SUNDAY       // 6
};

const char* day_to_string(enum DayOfWeek day) {
    const char* days[] = {
        "Monday", "Tuesday", "Wednesday", "Thursday",
        "Friday", "Saturday", "Sunday"
    };
    return days[day];
}

int is_weekend(enum DayOfWeek day) {
    return (day == SATURDAY || day == SUNDAY);
}

// ============================================================
// LOG LEVEL ENUM
// ============================================================

enum LogLevel {
    LOG_DEBUG = 1,
    LOG_INFO = 2,
    LOG_WARNING = 4,
    LOG_ERROR = 8,
    LOG_CRITICAL = 16
};

const char* log_level_to_string(enum LogLevel level) {
    switch (level) {
        case LOG_DEBUG: return "DEBUG";
        case LOG_INFO: return "INFO";
        case LOG_WARNING: return "WARNING";
        case LOG_ERROR: return "ERROR";
        case LOG_CRITICAL: return "CRITICAL";
        default: return "UNKNOWN";
    }
}

// ============================================================
// TRAFFIC LIGHT ENUM
// ============================================================

enum TrafficLight {
    RED,
    YELLOW,
    GREEN
};

const char* traffic_light_action(enum TrafficLight light) {
    switch (light) {
        case RED: return "STOP";
        case YELLOW: return "PREPARE TO STOP";
        case GREEN: return "GO";
        default: return "MALFUNCTION";
    }
}

// ============================================================
// MAIN - DEMONSTRATION
// ============================================================

int main() {
    printf("=== Enumerations in C ===\n\n");
    
    // HTTP Status Code Demo
    printf("--- HTTP Status Codes ---\n");
    enum HttpStatus status = HTTP_OK;
    printf("Status: %s\n", http_status_to_string(status));
    
    status = HTTP_NOT_FOUND;
    printf("Status: %s\n", http_status_to_string(status));
    
    // Check status range
    if (status >= 400 && status < 500) {
        printf("✗ Client Error\n");
    } else if (status >= 200 && status < 300) {
        printf("✓ Success\n");
    }
    
    // Days of Week Demo
    printf("\n--- Days of Week ---\n");
    for (enum DayOfWeek day = MONDAY; day <= SUNDAY; day++) {
        printf("%s", day_to_string(day));
        if (is_weekend(day)) {
            printf(" 🎉 (Weekend!)");
        }
        printf("\n");
    }
    
    // Log Level Demo
    printf("\n--- Log Levels ---\n");
    enum LogLevel current_level = LOG_WARNING;
    printf("Current log level: %s\n", log_level_to_string(current_level));
    
    // Bitwise flags (advanced)
    int log_mask = LOG_ERROR | LOG_CRITICAL;  // Enable multiple levels
    printf("Log mask includes ERROR: %s\n", (log_mask & LOG_ERROR) ? "YES" : "NO");
    printf("Log mask includes DEBUG: %s\n", (log_mask & LOG_DEBUG) ? "YES" : "NO");
    
    // Traffic Light Demo
    printf("\n--- Traffic Light State Machine ---\n");
    enum TrafficLight light = RED;
    for (int i = 0; i < 3; i++) {
        printf("Light: %s -> Action: %s\n",
               (light == RED ? "RED" : light == YELLOW ? "YELLOW" : "GREEN"),
               traffic_light_action(light));
        
        // Cycle through lights
        light = (light + 1) % 3;
    }
    
    // Enum Size Demo
    printf("\n--- Enum Properties ---\n");
    printf("Size of HttpStatus enum: %zu bytes\n", sizeof(enum HttpStatus));
    printf("Value of HTTP_OK: %d\n", HTTP_OK);
    printf("Value of MONDAY: %d\n", MONDAY);
    printf("Value of LOG_ERROR: %d\n", LOG_ERROR);
    
    printf("\n✓ Program completed successfully\n");
    return 0;
}
