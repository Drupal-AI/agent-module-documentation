# LTI Tool Provider — manual setup guide

**LTI Tool Provider** (`lti_tool_provider`) makes your Drupal site an **LTI
tool** — a resource that a Learning Management System (Moodle, Canvas, Blackboard,
and others) can **launch into with the learner already authenticated** and their
course role carried across. It supports LTI 1.0, 1.1, and 1.3.

Here's the flow it enables. A course in the LMS contains a link. A student clicks
it. The LMS signs a launch request that carries **who the student is, which course
they're in, and what role they hold**, and sends them to your Drupal site. Drupal
trusts that signature and shows the right thing — **without a second login**. For a
university or training provider running Drupal alongside an LMS, that's the
difference between a resource students actually reach and one stuck behind a
separate account.

Four submodules cover what a real integration needs:
**LTI Tool Provider Provision** (`lti_tool_provider_provision`) creates local
Drupal accounts on launch; **LTI Tool Provider Roles** (`lti_tool_provider_roles`)
maps LTI roles onto Drupal roles; **LTI Tool Provider Attributes**
(`lti_tool_provider_attributes`) carries LMS profile data into user fields; and
**LTI Tool Provider Content** (`lti_tool_provider_content`) links a launch to
specific content. The module requires the **[Key](https://www.drupal.org/project/key)**
module for storing the consumer credentials securely, and core's **Options**.

## The trust model — read this before you deploy

The security of the whole integration rests on the **launch signature**. A launch
request *asserts* an identity and a role; if that signature check is weak, anyone
who can reach the launch endpoint could claim to be an instructor. Three things
follow, and they're on you as the site owner:

- **The consumer secret is a credential.** Each LMS ("consumer") shares a secret
  with your site that signs its launches. Store it via the Key module and treat it
  like any other secret — never commit it, and rotate it if exposed.
- **Role mapping is a privilege decision.** Mapping the LTI `Instructor` role onto
  a Drupal role that has content permissions means **the LMS decides who gets
  those permissions**. Map deliberately and conservatively.
- **Replay protection matters.** LTI 1.x launches carry a nonce and timestamp
  precisely so a captured launch can't be replayed. Keep the module current and
  confirm signature/nonce handling on the exact release you deploy.

This guide is written for a **human** clicking through the admin UI. If you want
terse, token‑cheap references for an AI coding agent, read the sibling
[`agent/`](../agent/start.md) docs instead.

## Contents

1. [Installation](installation/index.md) — install with Composer, satisfy the
   `ext-oauth` PHP extension requirement, and enable the module and submodules.
2. [Configuration](configuration/index.md) — register an LTI consumer, store its
   secret with the Key module, and set up user provisioning, role mapping, and
   attribute mapping.

## Where it lives in the admin menu

Once enabled, the module adds LTI administration pages under Drupal's admin area
(the People / configuration area) for managing **LTI consumers**, user
provisioning, attribute mapping, and default entity provisioning. The exact pages
depend on which submodules you enable — see [Configuration](configuration/index.md).
