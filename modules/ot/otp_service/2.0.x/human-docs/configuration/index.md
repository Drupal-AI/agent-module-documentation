# Configuration

OTP Service is designed to be assembled into your own flow rather than configured
through one big settings screen. Setup is mostly about placing the block, granting
the right permissions, and (for developers) calling the validation service.

## 1. Let users set up their secret

The module provides a **block** that shows a QR code a user scans with their
authenticator app (Google Authenticator, Microsoft Authenticator, etc.) to
register their secret.

1. Go to **Structure → Block layout**.
2. Place the OTP secret‑setup block in a region where the relevant users will see
   it — for example on their account page or a dedicated "Set up OTP" page.
3. Save the block placement.

When a user scans the QR code, their secret is stored as a field on their user
entity for later validation.

> **Remember:** that stored secret is **not encrypted**. Limit who can view user
> field data, and keep this in mind when deciding which roles get OTP setup.

## 2. Set permissions

Two permissions control access under **People → Permissions**:

- **use otp_service form** — who may use the OTP validation form at
  `/otp/validation`. Grant it to the roles that will go through OTP verification.
  Because it's gated (not anonymous), the validation form is not an open
  brute‑force surface.
- **administer otp_service** — who may administer the module's settings. Restrict
  this to trusted administrators.

## 3. Protect a page or feature

There are two ways to use OTP Service to gate access:

- **Protect a bundle** — the module can protect access to a content bundle through
  its service, so users must pass OTP to reach it.
- **Custom flow** — for anything else, build a small form that collects the code
  from the user's authenticator app and, on submit, call the module's **validation
  service**. Use the true/false result to allow or deny access to the page or
  feature you're protecting. This is the developer‑oriented path and lets you focus
  on your app logic while the module handles the OTP mechanics.

## Verify it worked

Place the block, grant **use otp_service form** to a test role, and have a test
user scan the QR code to register a secret. Then confirm that entering a current
code from their authenticator app validates successfully, and an incorrect or
expired code is rejected.
