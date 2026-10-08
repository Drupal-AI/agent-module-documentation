<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# BankID authentication flow & RP client

## Front-end flow
1. `BankIDAuthenticateForm::buildForm()` renders the "Login with BankID" button
   (AJAX `::auth` opens an `authenticate_dialog` modal), a hidden `response` field
   (class `bankid-response`), and a hidden `submit` (class `login-submit visually-hidden`).
   Attaches library `bankid/bankid.authenticate`. `#cache max-age = 0`. If the user is
   already authenticated it shows a Logout button instead.
2. `js/authenticate.js` (`Drupal.behaviors.bankIDAuthenticate`), on the dialog:
   - GET `/api/bankid/authenticate` → stores `orderRef`, `qrStartToken`, `qrStartSecret`, `autoStartToken`.
   - Polls GET `/api/bankid/collect/{orderRef}` every 2s; while `status == 'pending'`
     it renders an animated QR (`bankid.{qrStartToken}.{time}.{HmacSHA256(time, qrStartSecret)}`)
     and a `bankid:///?autostarttoken=...` app link. Re-issues `authenticate` every 25s.
   - On `status == 'complete'`: writes `JSON.stringify(data)` into `.bankid-response`
     and clicks `.login-submit` to submit the form.
   - `cancel()` (dialog close) → GET `/api/bankid/cancel/{orderRef}`.

## Routes / controller (`BankIDController`)
All three are `_permission: 'access content'`, `no_cache: true`, JSON responses:
- `bankid.authenticate` → `BankIDClient::authenticate()` (default `endUserIp` 127.0.0.1).
- `bankid.collect` `/{orderRef}` (`order_ref` regex `[0-9a-z\-]+`) → `BankIDClient::collect($orderRef)`.
- `bankid.cancel` `/{orderRef}` → `BankIDClient::cancel($orderRef)`.
Each returns `BankIDResponse::getBody()` (the decoded BankID body plus injected
`status` / `shortName` / `message`).

## RP client (`BankIDClient extends GuzzleHttp\Client`)
Mutual-TLS client built from the active-env Key certs (see config/settings.md).
BankID RP API v6.0 methods, each POSTing JSON and wrapping the reply in `BankIDResponse`:
- `authenticate($endUserIp, $requirement, $userVisibleData, $userNonVisibleData, $userVisibleDataFormat)` → POST `auth`; visible/non-visible data base64-encoded. Returns `STATUS_PENDING`.
- `sign($endUserIp, $userVisibleData, ...)` → POST `sign`.
- `phoneAuth($personalNumber, $callInitiator, ...)` → POST `phone/auth`.
- `phoneSign($personalNumber, $callInitiator, ...)` → POST `phone/sign`.
- `collect($orderReference)` → POST `collect` `{orderRef}`; status taken from the BankID body (`pending`/`complete`/`failed`).
- `cancel($orderReference)` → POST `cancel`; returns `STATUS_OK`.
Exceptions are funnelled through `requestExceptionToBankIdResponse()` → `STATUS_FAILED`
(uses `getResponse()->getBody()` when the throwable exposes it).

## Response object (`BankIDResponse`)
Holds `status`, `body`, and a derived `shortName` (RFA code) mapped from BankID
`hintCode`/`errorCode`; message text resolved via `BankIDUserMessages::getMessage()`.
Accessors: `getStatus`, `getBody`, `getOrderRef`, `getPersonalNumber`
(`body.completionData.user.personalNumber`), `getAutoStartToken`, `getHintCode`,
`getErrorCode`, `getErrorDetails`, `getShortName`, `getMessage`.

## Login finalization (`BankIDAuthenticateForm::submitForm`)
1. Instantiate the configured integration plugin (`config.integration`).
2. `$response = $form_state->getValue('response')` (the JSON the JS placed in the hidden field).
3. `$account = $plugin->getUser($response)`; if null and `create_user` is on, `$plugin->createUser($response)`.
4. If an account resulted: pick redirect (request `destination` → `redirect_path` → user canonical),
   then `authmap->get(uid, PROVIDER_NAME)` and `externalAuth->userLoginFinalize($account, $authname, 'bankid')`
   (this regenerates the session). Else add the generic "Unrecognized username or password" error.
