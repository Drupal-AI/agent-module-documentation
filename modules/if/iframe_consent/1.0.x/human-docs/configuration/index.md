# Configuration

Iframe Consent's job is to decide, per iframe type, which consent group must be
granted before the embed may load — and what to show in the meantime. You set
this up on the module's configuration form under **Configuration**; open it as a
user with permission to administer the module's settings.

Before you start, make sure your **consent banner** (OneTrust, EU Cookie
Compliance, or similar) is in place and its consent groups/categories are
defined, because Iframe Consent maps onto those groups rather than inventing its
own.

## Global / domain iframe behavior

Configure how iframes behave globally, aligned with your site's domain‑level
consent settings. This is where you set the overall policy that individual iframe
types then follow, so blocked embeds line up with the consent categories your
banner manages.

## Consent groups per iframe type

For each iframe type, assign the **consent group(s)** that must be granted before
that embed is allowed to load. You can assign **more than one** consent group to
a single iframe type when an embed spans categories — the iframe loads once the
required consent is present. For example, you might map video embeds to your
"marketing" or "media" group and map location‑map embeds to your "functional"
group — matching however your banner names them.

## Customizable placeholder

Set the message or design shown **in place of** a blocked iframe. A good
placeholder tells visitors that the content is being held back until they consent
and how to grant it, so the page reads intentionally rather than looking broken.

## How it fits together

Because Iframe Consent relies on your consent banner for the actual "yes",
double‑check that the group names here match the groups your banner grants. When
a visitor has not consented, the iframe stays unloaded and the placeholder shows;
once they grant the matching group, the embed loads — no pre‑consent third‑party
requests in between.

## Save

Click **Save configuration** to apply your mappings and placeholder. Test as a
non‑consented visitor to confirm embeds are held back and the placeholder
appears.
