# Configuration

Setting up country‑aware language negotiation is a short sequence of steps across
Drupal's regional/language screens plus the module's country entities. Work through
them in order.

## 1. Add your languages

Go to **Configuration → Regional and language → Languages**
(`/admin/config/regional/language`) and add every language your site needs (for
example English, French, German).

## 2. Add your countries

Using the country entities this module provides, add the countries you want to
support and, for each one, specify which of your languages are available there. This
is what powers combinations like English‑in‑Canada versus French‑in‑Canada — each
country governs its allowed language‑country pairs.

## 3. Activate the country‑aware detection method

Go to **Configuration → Regional and language → Languages → Detection and
selection** (the language negotiation screen) and enable the **Language‑country
URL** detection method. Order it relative to the other methods so it takes priority
where you want country‑aware URLs to win, leaving plain path‑prefix (or other
methods) to handle the prefix‑less "international" state.

## 4. Set up fallbacks

Visit the module's **Language‑country fallbacks** screen under **Configuration →
Regional and language → Languages** to activate the convenient fallback behaviour
for the path prefix and the path‑alias manager. These fallbacks smooth over cases
where an exact language‑country match isn't available, improving the end‑user
experience.

## Using the current country in your code

Once configured, the module exposes a **CurrentCountry** service so custom code can
retrieve the visitor's country:

```php
$country_code = $this->currentCountry->getCurrentCountryCode();
```

Use it for country‑specific logic such as tax labels, pricing, or indexation
options. Because countries are fieldable entities, you can also add your own fields
to them and read those in downstream business logic.

## A note on the language switcher

If you want the core language‑switcher block to show only the languages available
for the current country, be aware that additional core changes may be needed — the
project references a core issue and patch for this. Check the module's page on
drupal.org for the current guidance, and remember this is alpha software with more
configuration options (custom prefix patterns, excluding admin pages, strict
negotiation) still on the roadmap.
