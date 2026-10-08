TFA Web Services (`services_tfa`) is a deprecated submodule of TFA that exposes a second-factor code-validation endpoint for the contrib Services module.

---

The submodule ships a single Services `ServiceDefinition` plugin, `GenericValidation` (id `tfa_login`, path `auth/tfa`, POST), that lets an external client submit a user id, a validation plugin id, and a one-time code to be validated against that user's configured TFA method. It is intended for headless or decoupled setups that authenticate over the Services module rather than the browser login form. The submodule depends on both the `tfa` base module and the contrib `services` module and provides no routes, permissions, config, or UI of its own — all validation is delegated to the base module's validation plugin managers. As of this release the whole submodule is marked `lifecycle: deprecated` and the `GenericValidation` class is `@deprecated in tfa:8.x-1.4` and removed in `tfa:2.0.0-alpha3` with no replacement, so new integrations should not adopt it.

---

- Validate a TFA one-time code for a user from an external client via the Services module (`POST auth/tfa`).
- Add a second-factor check to a legacy Services-based authentication flow.
- Confirm a TOTP/HOTP or recovery code programmatically by passing `id`, `plugin_id`, and `code`.
- Restrict which validation plugins the endpoint accepts to those allowed in `tfa.settings`.
- Reject codes that were recently used, reusing the base module's replay protection.
- Maintain an existing decoupled site that still relies on the deprecated endpoint (while planning migration off it).
- Reference the plugin as an example of integrating TFA validation into a custom web-service definition.
- Evaluate whether to keep or remove Services-based TFA validation given the module's deprecation.
