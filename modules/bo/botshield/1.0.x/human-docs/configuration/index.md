# Configuration

BotShield is configured from a single settings form at the `botshield.settings`
route (under **Configuration**). Only users with the module's permissions can
reach it, so grant those to trusted administrators only.

The settings fall into a few areas, matching what the module does:

## Classification

Decide how BotShield tells good bots (search-engine crawlers you want to keep)
from bad bots (scrapers and abusive clients). Tuning classification is what keeps
legitimate crawlers from being caught by the same rules that block abuse.

## Rate limiting

Set the thresholds that define "too many requests" — how much traffic from a
single client IP is allowed before the module treats it as abusive. Lower limits
catch aggressive clients sooner but risk false positives on shared IPs; higher
limits are more forgiving.

## Blocking

Choose what happens when a client crosses a limit or is classified as a bad bot —
for example throttling or blocking further requests. Remember that blocking is by
client IP, so behind a proxy this only works correctly once trusted-proxy
settings are in place, and an attacker rotating IPs can still slip through.

## Geo enrichment and reporting

BotShield enriches requests with geographic data and reports on the bot activity
it observes. Use the reporting to see which clients are being caught and to
decide whether your classification and rate-limit thresholds need adjusting.

## A note on scope

These settings mitigate **application-layer** bot abuse only. They do nothing
against a true network or volumetric flood — put a CDN or WAF in front of the
site for that. Configure BotShield for the scraping and abuse that actually
reaches Drupal, and treat it as one layer among several.
