<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Meeting API BBB provides a BigBlueButton implementation for the Meeting API.

---

Meeting API: BigBlueButton provides a **BigBlueButton (BBB) provider for the Meeting API** — so Drupal can
create and join BigBlueButton video meetings/webinars through the Meeting API abstraction. It depends on the
Meeting API and Key modules, in the Meeting API package.

Use it to run BBB meetings from Drupal. It is an integration feature and it handles secrets **correctly**: the
BBB server **shared secret/API credentials are stored via the Key module** (secret provider), not plain config.
Data-handling: it talks to your **BigBlueButton server** (which handles the actual meetings/recordings — a
separate system to secure), over HTTPS. Join URLs are effectively **capabilities** (anyone with a join link can
enter the meeting), so treat them accordingly. It has no access-control role. Configure the BBB server and Key.

---

- Provide a BigBlueButton meeting provider.
- Create/join BBB video meetings.
- Use the Meeting API abstraction.
- Depend on Meeting API and Key.
- Serve video meetings.
- Run webinars.
- Store the BBB secret via the Key module (correct).
- Talk to your BBB server (secure it separately) over HTTPS.
- TREAT join URLs as capabilities (anyone with the link joins).
- Have no access-control role.
- Configure the BBB server and Key.
- Handle BBB meetings.
- Create meetings.
- Configure the provider.
- Join meetings.
- Handle the integration.
- Run meetings.
- Manage webinars.
- Secure the secret (Key) + join links.
- Provide BBB meetings.
