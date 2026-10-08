# The W3C token authentication provider

To let the external validator fetch access-restricted pages "as a logged-in user", the module ships a
**global** authentication provider plus a token manager. Relevant when auditing auth behaviour.

## Pieces

- `W3CTokenManager` (`w3c.token`, `src/W3CTokenManager.php`)
  - `createAccessToken($user)`: token = `md5('w3c_validator' . (time()+20) . mt_rand() . uid)`, stored in
    table `w3c_access_token` with `expiration = time()+20`, `rand`, `uid`.
  - `rewokeAccessToken($token)`: deletes the row.
  - `getUserFromToken($token)`: `SELECT` by token, `User::load($row->uid)`.
- `W3CTokenAuth` (`w3c.authentication.token_auth`, `src/Authentication/Provider/W3CTokenAuth.php`),
  tagged `authentication_provider` with **`global: TRUE`**, priority 0.
  - `applies()`: request has query param `HTTP_W3C_VALIDATOR_TOKEN`.
  - `authenticate()`: if a user resolves from the token, logs a notice and returns that account
    (authenticating the request as that user).

## How it is used

During `W3CProcessor::validateAllPages()` with `use_token` on, the processor creates a token for the
current (admin) user and passes it as the `HTTP_W3C_VALIDATOR_TOKEN` query parameter on the page URLs it
hands to the validator; the validator's HTTP fetch of those URLs then carries the token, and this
provider authenticates each fetch as that user so restricted markup is rendered. The token is revoked
when the batch finishes.

## Behavioural notes (for auditors)

- The provider is global, so ANY request carrying a valid `HTTP_W3C_VALIDATOR_TOKEN` query value
  authenticates as the token's user — not just validator traffic.
- Tokens are `md5`-derived (128-bit space) from `time()+20`, `mt_rand()` (32-bit, non-CSPRNG) and the
  uid; they exist only briefly (created then revoked around a validation run) and are keyed by the exact
  md5, making remote guessing within the window impractical.
- `getUserFromToken()` does not itself check `expiration` (the row is short-lived and deleted on
  revoke); a token whose row still exists would still resolve. Prefer running validation against a
  self-hosted validator so tokens are not emitted to a third-party service.
