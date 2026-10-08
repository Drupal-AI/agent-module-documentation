<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Registration Confirmation — agent index

Sends an immediate confirmation email when a registration reaches its **completed** state. No
settings form, no configure route, no permissions. Config is **three third-party settings on each
`registration_type`**.

- **The confirmation settings (enable / subject / message), storage & tokens** →
  [configure/confirmation.md](configure/confirmation.md)

Key fact: `registration.type.<id>` -> `third_party_settings.registration_confirmation.{enable
(bool), subject (string), message ({value, format})}`. An EventSubscriber sends the mail via the
base module's `RegistrationMailer` on completion; tokens work when the `token` module is enabled.
