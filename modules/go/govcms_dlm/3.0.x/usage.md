<!-- SPDX-License-Identifier: GPL-2.0-or-later -->
GovCMS DLM adds optional DLM to emails sent from Drupal mail.

---

GovCMS DLM adds an optional **Dissemination Limiting Marker** (DLM) — an Australian-government protective
marking (e.g. "OFFICIAL", "OFFICIAL: Sensitive") — to the subject/body of emails Drupal sends, so outbound
mail carries the required security classification marking. It provides its own permissions, in the GovCMS
package.

Use it on Australian-gov (GovCMS) sites that must mark email. This is a **compliance/security-labelling**
feature — the marking is a governance/handling label, not encryption, so it signals classification but does
not itself protect the content in transit (use proper mail transport security for that). It has no
access-control role beyond its permission. Configure the DLM marking.

---

- Add a DLM protective marking to email.
- Mark outbound mail (OFFICIAL etc.).
- Meet gov email-marking requirements.
- Provide its own permissions.
- Label email classification.
- Serve GovCMS/Australian-gov sites.
- Signal classification, not encryption.
- Use mail transport security for protection.
- Have no access-control role beyond permission.
- Configure the DLM marking.
- Handle email marking.
- Mark emails.
- Add protective markings.
- Configure the marker.
- Label emails.
- Handle DLM.
- Mark mail.
- Configure classification.
- Add markings.
- Provide email marking.
