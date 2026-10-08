<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
Travel Safety is a form-driven check-in system: travelers register their itinerary, self-report safe arrival/boarding through tokenized links, and cron emails administrators about anyone unaccounted for.
---
The public form at `/travel-safety` (`TravelInformationForm`, permission `access travel safety form`) collects flight info, emergency contact and preferred contact method into a `travel_safety_submissions` table. On submission the module emails the traveler capability links for four actions — mark safe at accommodation, mark safely boarded, update, and delete — each carrying a cryptographically strong token generated with `Crypt::randomBytesBase64()`. The check-in controller routes (`/travel-safety/check-in/accommodation/{token}`, `/boarded/{token}`) look the token up and flag the record; update/delete are handled by CSRF-protected forms. `hook_cron` (via `CronHelper`) finds records whose arrival/departure time plus a configurable grace window has passed without a check-in and dispatches digest notifications (with BCC to configured + system addresses), and also performs retention-based deletion.

Configuration lives at `/admin/config/people/travel-safety` (`administer travel safety module`): grace/check-in window, notification recipients, timezone, conference name, and retention. An admin list of all submissions is at `/admin/people/travel-safety-submissions` (`view travel safety submissions`, restricted). Setup: enable, configure the settings, grant the form permission to the appropriate role, and ensure cron runs. Access to the sensitive submission list and settings is permission-gated; the check-in/update/delete actions are protected by unguessable per-submission tokens (capability URLs).
---
- Collect traveler itineraries via the `/travel-safety` form.
- Record flight numbers, airports and arrival times.
- Capture an emergency contact and preferred contact method.
- Let a traveler mark themselves safe at their accommodation.
- Let a traveler mark themselves safely boarded on the return flight.
- Email travelers tokenized manage/check-in links on submission.
- Update a submission via a tokenized update link.
- Delete a submission via a tokenized delete link.
- Email admins a digest of unaccounted travelers via cron.
- Configure the check-in grace window at the settings page.
- Set notification (and BCC) recipient addresses.
- Set the conference timezone and name.
- Configure retention-day auto-deletion of old submissions.
- View all submissions at `/admin/people/travel-safety-submissions`.
- Grant `access travel safety form` to attendees.
- Restrict submission viewing to trusted staff.
- Alter outgoing digest emails via `hook_mail_alter()`.
- Prioritise overdue-boarding emails using the mail key.
- Run automated safety checks on regular cron runs.
- Track safe-arrival status per traveler.
- Generate strong, unguessable per-action tokens.
- Support a conference/event travel-safety programme.
- Sort and paginate the admin submissions table.
- Remove personal data after the configured retention period.
