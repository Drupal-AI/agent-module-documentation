# Authentication, launch/return flow and internals

## The two authentication providers

Both are tagged `authentication_provider` (priority 100) and extend
`Authentication\Provider\LTIToolProviderBase`. Drupal's authentication subscriber calls
`applies($request)` then `authenticate($request)` early in the request.

- **`lti_auth_v1p0`** — service `authentication.lti_tool_provider.v1p0`,
  `LTIToolProviderV1P0`. `applies()` → `isValidLaunchRequest()`: a POST carrying
  `lti_message_type=basic-lti-launch-request`, `lti_version` in `{LTI-1p0, LTI-1p2}`, non-empty
  `oauth_consumer_key` and `resource_link_id`.
- **`lti_auth_v1p3`** — service `authentication.lti_tool_provider.v1p3`, `LTIToolProviderV1P3`.
  `applies()` → `isValidLaunchRequest()`: non-empty `id_token` and `state`.

### `LTIToolProviderBase::authenticate()` (`src/Authentication/Provider/LTIToolProviderBase.php:113`)

1. `validate(convertToPsrRequest($request))` → returns an `LTIToolProviderContext` (throws on any
   validation failure).
2. `provisionUser($context)` → resolves or creates the Drupal user (see below).
3. Dispatches `PROVISION_USER`, then `AUTHENTICATED` (`LtiToolProviderEvents`).
4. `user_login_finalize($user)`.
5. Stores the context in the session: `$session->set('lti_tool_provider_context', $context)`.
6. Returns the user. Any exception is caught, logged as a warning, `LTIToolProviderContext::sendError()`
   is invoked, and `NULL` is returned (request stays anonymous).

> Note: the base class deliberately resolves `@event_dispatcher` lazily via
> `eventDispatcher()` → `\Drupal::service('event_dispatcher')` rather than constructor injection, to
> avoid a `CircularReferenceException` between `authentication_collector` and the event subscribers
> (documented in the class docblock). Do not inject `@event_dispatcher` into an auth provider here.

### `validate()` — where the request is verified

- **1.0 (`LTIToolProviderV1P0::validate()`):** constructs a PECL
  `\OAuthProvider(["oauth_signature_method" => OAUTH_SIG_METHOD_HMACSHA1])`, registers
  `consumerHandler` (loads the consumer by `oauth_consumer_key`, sets `consumer_secret`) and
  `timestampNonceHandler`, sets `is2LeggedEndpoint(TRUE)` / `isRequestTokenEndpoint(FALSE)`, then
  `checkOAuthRequest()` performs HMAC-SHA1 signature verification. It then reads the configured
  `name`/`mail` payload fields, validates the email, and returns
  `new LTIToolProviderContext(new UserIdentity(0, $name, $mail), $payload)` with `consumer_id` /
  `consumer_label` merged in.
- **1.3 (`LTIToolProviderV1P3::validate()`):** `new ToolLaunchValidator($registrationRepository,
  $nonceRepository)` → `validatePlatformOriginatingLaunch($request)`; throws if `hasError()`. Returns
  `new LTIToolProviderContext($payload->getUserIdentity(), $payload, $registration)`.

### `provisionUser()` (`LTIToolProviderBase.php:174`)

Reads `getName()` / `getEmail()` from the context's `UserIdentity`; both must be non-empty (email must
pass `filter_var(... , FILTER_VALIDATE_EMAIL)` in 1.0). It loads an active user by `name`, then by
`mail`; if found, returns it. Otherwise it `User::create()`s a new active account with a generated
password, dispatches `CREATE_USER`, and saves. Roles/attributes are applied afterwards by the
submodule subscribers on `PROVISION_USER`.

## Launch controllers (post-auth redirect)

After the auth provider has stored the context, the launch route's controller reads it and redirects:

- `LTIToolProviderV1P0Launch::route()` (`/lti`) — reads `lti_tool_provider_context` from the session,
  dispatches `LtiToolProviderEvents::LAUNCH` with destination `context['custom_destination'] ?? '/'`,
  redirects there. `access()` re-checks `isValidLaunchRequest()`.
- `LTIToolProviderV1P3Launch::route()` (`/lti/v1p3/launch`) — same, using the `destination` custom
  claim; on error redirects to `system.403`.

## Return controllers (log out, back to platform)

- `LTIToolProviderV1P0Return::route()` (`/lti/return`) and `LTIToolProviderV1P3Return::route()`
  (`/lti/v1p3/return`) read the session context, trigger the page-cache kill switch, resolve the
  return URL (`launch_presentation_return_url` / the 1.3 launch-presentation claim), **validate it**
  (`validateReturnUrl()`: scheme must be http/https, and the host must match the registered platform
  `platform_id` / audience when known), dispatch `LtiToolProviderEvents::RETURN`, `user_logout()`, and
  redirect via `TrustedRedirectResponse`.

## OIDC / JWKS helpers (1.3)

- `LTIToolProviderV1P3Login::route()` (`/lti/v1p3/login`) — OIDC third-party login initiation via
  `OidcInitiationRequestHandler(new OidcInitiator($registrationRepository))`.
- `LTIToolProviderV1P3Jwks::route()` (`/lti/v1p3/jwks`) — publishes the tool's public JWKS for the
  `client_id`, built from the consumer's `public_key` Key entity via `JwksRequestHandler`/`JwksExporter`.

## Repositories, entities, context

- `lti_tool_provider.nonce.repository` (`LTIToolProviderNonceRepository`, implements the OAT
  `NonceRepositoryInterface`) — `find()` / `save()` / `purgeExpired()` over the
  `lti_tool_provider_nonce` entity; used by the 1.3 validator. The 1.0 provider uses its own
  `timestampNonceHandler` against the same entity (±5-min window; `hook_cron` purges after
  `LTI_TOOL_PROVIDER_NONCE_EXPIRY`).
- `lti_tool_provider.registration.repository` (`LTIToolProviderRegistrationRepository`, implements
  `RegistrationRepositoryInterface`) — `findByClientId()`, `findByPlatformIssuer()`, `findAll()`; each
  builds an OAT `Registration` (Platform + Tool + `KeyChain` from the consumer's Key entities).
- `LTIToolProviderContext` (implements `LTIToolProviderContextInterface`) — the session object.
  `getVersion()` returns `V1P0`/`V1P3`; for 1.0 `getContext()` returns the raw launch array, for 1.3
  `getPayload()` returns the OAT `LtiMessagePayloadInterface` and `getRegistration()` the registration.
  `getUserIdentity()` returns the OAT `UserIdentity`. Static `sendError($message, $context)` redirects
  to the platform's return URL with an `lti_errormsg` query (scheme-validated to http/https).
