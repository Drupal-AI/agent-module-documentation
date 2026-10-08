<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Mail composer (mail_composer) — agent index

**Pure code API: an OOP, chainable, Twig-template email builder wrapping Drupal's core mail manager.**

- **Version:** 1.0.x
- **Core:** ^9 || ^10 || ^11 · **Dependencies:** none (core mail only)
- **Service:** `mail_composer.manager` (`Drupal\mail_composer\Manager`) — args `@plugin.manager.mail`, `@language_manager`, `@config.factory`.
- **Classes:** `Manager` (setters `setFrom/To/Subject/Body/ReplyTo/Key/Langcode/Headers`, `compose()`, `send()`), `Email`/`EmailInterface` (subclass to declare properties), `Exception\MailingException`.
- **Required to send:** `to`, `langcode`, `key` (else `MailingException`). Delivery uses the site mail plugin.

**Security:** no routes, permissions, forms, or config; no network/credentials of its own. No security findings.

See [api/usage.md](api/usage.md).