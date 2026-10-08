<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
LTI Tool Provider makes Drupal an LTI tool, so a learning management system — Moodle, Canvas, Blackboard — can launch into it with the learner already authenticated and their role carried across.

---

LTI is how educational systems federate: a course in the LMS holds a link, a student clicks it, and the LMS sends a signed launch that says who the user is, which course they are in and what role they hold; the tool trusts that signature and shows them the right thing without a second login. The module supports **both LTI generations**. For **LTI 1.0/1.1** it registers the `lti_auth_v1p0` authentication provider, which verifies the launch's OAuth 1.0a HMAC-SHA1 signature against the consumer's shared secret using the PHP `ext-oauth` extension, with a nonce and ±5-minute timestamp window to stop replays — so 3.0.0 needs `ext-oauth` installed (in DDEV, `ddev config --webimage-extra-packages='php${DDEV_PHP_VERSION}-oauth'` then `ddev restart`). For **LTI 1.3** it registers `lti_auth_v1p3`, which runs the standard OIDC login-init and validates the signed `id_token` against the platform's published keys via the `oat-sa/lib-lti1p3-core` library; the tool exposes its own public keys at `/lti/v1p3/jwks`. Each remote platform is stored as a **consumer** entity at `admin/config/lti-tool-provider/consumer` (key + secret for 1.0; issuer, client id, deployment id, JWKS URL and a **Key**-module RSA keypair for 1.3), which is why the module depends on `key`. Once a launch is verified the module finds or creates the matching Drupal user, logs them in and redirects to the configured destination. Four optional submodules complete a real integration: **roles** maps LTI roles onto Drupal roles, **attributes** copies LTI values into user fields, **provision** auto-creates or loads an entity per course/resource, and **content** adds LTI 1.3 Deep Linking so a platform can pick site content to embed. All of it is customised through events (`LtiToolProviderEvents::LAUNCH`, `PROVISION_USER`, `RETURN`, …) rather than hooks. Version **3.0.0** runs on core `^10.3 || ^11` and requires PHP `^8.3`.

---

- Launch Drupal content from Moodle.
- Integrate a course with Canvas.
- Authenticate learners from an LMS via LTI 1.3.
- Authenticate learners from a legacy LTI 1.0/1.1 platform.
- Carry a student's course role into Drupal.
- Provision Drupal accounts automatically from LTI launches.
- Map LTI roles to Drupal roles per launch.
- Copy LMS profile attributes into user fields.
- Embed a Drupal tool inside a course via an iframe.
- Avoid a second login for students.
- Register multiple LMS platforms as separate consumers.
- Publish the tool's JWKS for an LTI 1.3 platform.
- Auto-create a node per course context on launch.
- Redirect a learner straight to a provisioned entity.
- Let a teacher pick Drupal content to embed with Deep Linking.
- Carry course and resource-link context into Drupal.
- Support Blackboard integration.
- Send the learner back to the LMS with the return flow.
- Federate identity from an LMS into Drupal.
- Support a university's or training provider's LMS platform.
- Launch an assessment, simulation or resource from a course.
- Customise the post-launch destination with an event subscriber.
