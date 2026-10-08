# Configuration

Setting up LTI Tool Provider means establishing **trust with each LMS** (a
"consumer") and then deciding how launches turn into Drupal accounts, roles, and
attributes. Because the launch signature is the whole security model, the credential
handling and role mapping below are the parts to get right.

## Open the LTI administration pages

1. Log in as an administrator (a user with the module's LTI administration
   permission).
2. Open the LTI administration area under Drupal's admin menu (in the
   People / configuration area). The pages available depend on which submodules
   you've enabled.

## Register an LTI consumer

A **consumer** is an LMS that is allowed to launch into your site. For each one you
register:

- **Consumer key** — the public identifier the LMS sends with each launch. It
  identifies which consumer (and therefore which shared secret) a launch belongs
  to.
- **Consumer secret** — the shared secret that signs the LMS's launch requests.
  **This is a credential.** Store it with the **Key** module rather than pasting it
  into plain configuration, keep it out of version control, and rotate it if it's
  ever exposed. The same key/secret pair must be entered on the LMS side when the
  tool link is created.

You give the LMS administrator your site's **launch URL** plus this key and secret;
they enter them into the external‑tool configuration on their side. From then on,
launches from that consumer are trusted only if their signature verifies against
the stored secret.

> **Confirm the trust mechanics on your release.** The signature check, and the
> nonce/timestamp **replay protection** that stops a captured launch being reused,
> are the safeguards that make the whole thing safe. Keep the module current and
> verify these behave correctly on the exact version you deploy rather than
> assuming.

## User provisioning (Provision submodule)

With `lti_tool_provider_provision` enabled, a launch can **create or load a local
Drupal account** for the incoming user automatically, so students don't need a
separate registration. You can also configure a default entity to be created or
loaded on launch. Decide what happens for a first‑time user and how their account
is matched on return.

## Role mapping (Roles submodule)

With `lti_tool_provider_roles` enabled, you map **LTI roles to Drupal roles** — for
example mapping the LTI `Instructor` role to a Drupal editor role and `Learner` to
authenticated.

**This is a privilege decision, not a cosmetic one.** Whatever Drupal role you map
`Instructor` (or any LTI role) onto, the **LMS now effectively decides who receives
that role's permissions**. Map to the least‑privileged Drupal role that does the
job, and be especially careful before mapping any LTI role onto a Drupal role with
content‑editing or administrative permissions.

## Attribute mapping (Attributes submodule)

With `lti_tool_provider_attributes` enabled, you map **LTI launch data** (name,
email, and other profile attributes sent by the LMS) onto **Drupal user fields**,
so provisioned accounts carry the right profile information. Map only the fields
you actually need.

## Content redirection (Content submodule)

With `lti_tool_provider_content` enabled, you can send a launch to **specific
content** — so a link in a given course lands the student on the intended Drupal
page rather than a generic destination.

## Save and test

Save each configuration form, then do an end‑to‑end test: configure the tool link
in your LMS with the launch URL, consumer key, and secret, and click it as a test
student. Confirm the account is provisioned, the correct role is applied, and the
learner lands on the right content — all without a second login.
