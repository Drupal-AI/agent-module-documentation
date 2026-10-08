# Configuration

Setup is deliberately simple — no source‑code changes are needed. Open the Sirdata
CMP settings form (under **Configuration**; administering it requires the module's
own permission).

## 1. Set up your CMP in Sirdata

Create or log in to your Sirdata CMP account and configure your consent banner there
(or start from Sirdata's pre‑configured setup). This is where you control the
banner's languages, design, position, colours, logo, dark mode and so on — those
options live in Sirdata, not in Drupal.

## 2. Paste your IDs into Drupal

On the module's settings form, enter the two identifiers from your Sirdata account:

- **CMP Sirdata Customer Key** — your Sirdata customer key.
- **CMP Sirdata App Key** — your Sirdata application key.

Both fields are required. Tick **Enable CMP Sirdata** as well, then save. The module
then loads Sirdata's CMP scripts on your site's front end and the banner appears.

> **Naming note:** Sirdata's own project page refers to these as your "partner" and
> "config" IDs. In this Drupal module the two fields are labelled **Customer Key** and
> **App Key** — they are the same two identifiers from your Sirdata account.

## 3. Wire your tags to the consent signal

The CMP collects consent, but it's up to you to make your tracking respect it.
Connect your analytics and marketing tags to the CMP's consent signal so they only
fire when the visitor has consented. Sirdata provides tag‑conditioning tooling
(usable with or without a tag manager) for exactly this — see Sirdata's technical
documentation.

## 4. Add the required legal mentions

Add the mandatory mentions to your Privacy Policy pages as Sirdata instructs. Remember
that displaying the CMP is only one part of a compliance process — it does not, by
itself, guarantee compliance with GDPR, ePrivacy, CCPA or other privacy laws.

## A note on data handling

Because the module loads Sirdata's third‑party script, that script may set its own
cookies and contact Sirdata to manage consent. Factor this into your privacy
documentation.
