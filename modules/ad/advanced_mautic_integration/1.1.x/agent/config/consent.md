<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
# Consent gate (`track.consent_required`) & the JS consent contract

New in 1.x: the tracker can be held back until the visitor consents. This is a **browser-side** gate —
nothing changes on the server, so pages stay as cacheable as before. Turn it on with the *Load the
tracker only after the visitor consents* checkbox (`track.consent_required` in
`advanced_mautic_integration.settings`), or let the `advanced_mautic_integration_klaro` submodule turn
it on for you.

## Behaviour (in `js/tracking_events.js`)

The tracking library keeps a tri-state `state.consent`: `null` (undecided), `true` (granted), `false`
(refused/withdrawn), plus `state.required` from `consentRequired`.

- **Gate off** (`required` false): `loadTracker()` runs on attach and every event is sent — the
  pre-consent behaviour every site had before this feature.
- **Gate on, undecided**: the tracker script is not loaded, no request reaches Mautic, no `mtc_`
  cookie is set. Events raised in the meantime (including the landing pageview) are queued in memory.
- **Consent granted**: `loadTracker()` fires once and the queued events are flushed.
- **Consent refused/withdrawn**: the queue is dropped and no further events are sent. A withdrawal
  cannot unload an already-loaded script or delete cookies — that is the consent manager's job.

## The contract (defined as soon as the library is parsed)

`Drupal.advancedMauticIntegration` exposes:

- `consent(granted)` — report the visitor's real decision (`true`/`false`). Idempotent; safe before
  DOM ready. On a *change* of decision it dispatches an `advancedMauticIntegration:consent`
  `CustomEvent` on `document` (with `detail.granted`) so the rest of the site can gate its own Mautic
  snippets (Focus, embedded forms) on the same answer.
- `hasConsent()` — `true` when events may be sent (no gate, or granted).

Call `consent()` with the visitor's actual choice, not a default: calling `consent(false)` for an
undecided visitor throws away the held landing pageview for nothing. The README ships a worked
**EU Cookie Compliance** adapter and a *"gate the rest of your Mautic code"* pattern using the
document event.

## Wiring Klaro

`drush en advanced_mautic_integration_klaro` sets `track.consent_required = TRUE` and reports Klaro's
decision to `consent()`. See
[../../../modules/advanced_mautic_integration_klaro/1.1.x/agent/start.md](../../../modules/advanced_mautic_integration_klaro/1.1.x/agent/start.md).
