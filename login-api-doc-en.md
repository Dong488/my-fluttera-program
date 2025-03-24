
# User Authentication API Documentation (for Flutter App)

This document describes the API endpoints for login, registration, and password change, matching the usage in the frontend Flutter app (`ApiService.dart`).

---

## Login API

- **Method**: POST  
- **Endpoint**: `/login`  
- **Headers**: `Content-Type: application/json`

### Request Parameters (JSON):
| Name     | Type   | Required | Description        |
|----------|--------|----------|--------------------|
| email    | String | Yes      | User email or account |
| password | String | Yes      | Login password     |

### Response Parameters (JSON):
| Name                | Type   | Description                                  |
|------------------|---------|-------------------------------------|
| token                | String | Auth token used for requests  |
| userId               | String | Unique user ID                             |
| accountName | String | Display name (same as email)   |

### Example Request:
```json
{
  "email": "test@example.com",
  "password": "123456"
}
```

### Example Response:
```json
{
  "token": "abc123xyz",
  "userId": "10001",
  "accountName": "test@example.com"
}
```

---

##  Registration API

- **Method**: POST  
- **Endpoint**: `/register`

### Request Parameters and Response: Same as Login API  
Returns token and user info upon successful registration.

---

##  Change Password API

- **Method**: POST  
- **Endpoint**: `/change-password`

### Request Parameters (JSON):
| Name        | Type   | Required | Description        |
|-------------|--------|----------|--------------------|
| email       | String | Yes      | User email         |
| oldPassword | String | Yes      | Current password   |
| newPassword | String | Yes      | New password       |

### Example Request:
```json
{
  "email": "test@example.com",
  "oldPassword": "123456",
  "newPassword": "newpassword123"
}
```

### Success Response:
- Status: 200 OK
- Body: Optional `{ "success": true }` or empty

---

Dart Request Example

```dart
final res = await http.post(
  Uri.parse('https://your-api-url.com/login'),
  headers: { "Content-Type": "application/json" },
  body: jsonEncode({ "email": "xxx", "password": "xxx" }),
);
```

