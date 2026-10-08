The Klaro consent submodule of Advanced Mautic Integration holds the Mautic tracker back until the visitor consents to it in the Klaro consent manager, so no request to Mautic and no `mtc_` cookie happens before opt-in.

---

Klaro normally blocks a script by rewriting its `<script src>` into a placeholder while the page is built, but the Mautic tracker is created in the browser after load, so there is nothing in the markup for Klaro to rewrite. This submodule bridges that gap: it enables the parent module's consent gate (`track.consent_required`), attaches a small library (`advanced_mautic_integration_klaro/consent`) alongside the tracker, and reports every Klaro decision to the parent's `Drupal.advancedMauticIntegration.consent()` contract. On install it also creates a Klaro service named `mautic` (unless one exists) via the shipped `config/optional/klaro.klaro_app.mautic.yml`, listing the `^mtc_` and `^mautic_` cookies so Klaro cleans them up on withdrawal. The Klaro service that governs the tracker is chosen on the parent's settings form (a selector added by `hook_form_..._alter`), so a site can point it at a service shared with other Mautic integrations (e.g. Mautic Audiences). A `hook_runtime_requirements` check surfaces the silent misconfigurations (no/disabled service, gate off, or anonymous users lacking *Use Klaro UI*) on the status report. It depends on the parent module and the Klaro module; it defines no routes, permissions, or entities of its own.

---

- Load the Mautic tracker only after the visitor grants consent in Klaro.
- Prevent any Mautic request or `mtc_` / `mautic_` cookie before opt-in, for GDPR/ePrivacy compliance.
- Enable the parent module's consent gate automatically on install (no manual toggle).
- Auto-create a Klaro `mautic` service with the right cookie patterns for cleanup on withdrawal.
- Reuse an existing Klaro service (e.g. one created for Mautic Audiences) so visitors see one switch.
- Choose the governing Klaro service from the Mautic settings form.
- Report consent grants and withdrawals to the tracker in real time via Klaro's `applyConsents`.
- Send the pageview held back during opt-in once the visitor accepts, so the landing page is not lost.
- Stop sending Mautic events immediately when the visitor withdraws consent.
- Let Klaro remove the Mautic cookies when consent is withdrawn.
- Diagnose "tracker never loads" via the status-report requirement checks.
- Warn when the selected Klaro service is missing or disabled.
- Warn when the consent gate is off while this module is enabled.
- Warn when anonymous visitors lack the *Use Klaro UI* permission (so they are never asked).
- Leave the gate on when uninstalled, so removing the submodule never silently resumes tracking.
