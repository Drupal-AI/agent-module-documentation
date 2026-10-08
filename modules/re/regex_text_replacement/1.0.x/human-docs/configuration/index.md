# Configuration

Regex Text Replacement is configured **per text format**, not on a global settings
page. You enable the filter on a format and give it a list of patterns; it then
rewrites the rendered output of any content using that format.

## Add the filter to a text format

1. Log in as a user with the **Administer filters** permission (an administrator by
   default).
2. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
3. Edit the text format you want the replacements to apply to (for example *Full
   HTML* or *Basic HTML*).
4. In the **Enabled filters** list, tick **Regex Text Replacement**.

## Write your patterns

With the filter enabled, its settings appear in the **Filter settings** section
lower down the page. There you'll find a **textarea** where you enter one
replacement per line, in the form:

```
pattern||replacement
```

- The **pattern** is a PCRE regular expression, including its delimiters and any
  flags — for example `/old-domain\.com/i`.
- The `||` separates the pattern from the replacement.
- In the **replacement**, `(1)`-style backreferences are translated to `$1`, so
  you can reuse captured groups.

For example, to rewrite every `<h2>` to an `<h3>`:

```
/<h2([^>]*)>(.*?)<\/h2>/mi||<h3$1>$2</h3>
```

Add as many lines as you need; they run in order. Click **Save configuration** when
done.

## Cautions — read before deploying to a busy site

The patterns come from the text-format settings, which need the **Administer
filters** permission — already one of the most powerful permissions on a site. So
these are configuration hazards to get right, not vulnerabilities, but they matter:

1. **Catastrophic backtracking (a performance/ReDoS risk).** A regex that runs
   fine on a short paragraph can hang for a long time on a large node — and this
   filter runs on **every render of every field** that uses the format. Keep
   patterns tightly anchored and avoid nested, open-ended quantifiers.

2. **Filter order matters.** Filters run in the order shown on the format page. A
   replacement that inserts markup **after** the HTML-restricting/"limit allowed
   tags" filter has already run inserts that markup **unfiltered**. Position the
   Regex Text Replacement filter deliberately relative to the HTML filters.

3. **Regex on HTML is fragile.** HTML is not a regular language, so a pattern that
   matches your best-case content can misfire on messier markup. Anchor patterns
   tightly and **test against the worst content on your site, not the cleanest**.

## Robustness

If a pattern fails at runtime, the module logs a warning (including the underlying
error) and simply **skips that line** rather than throwing — so a mistake degrades
to "no replacement" instead of a white screen. Check your logs after adding
patterns to confirm none are silently failing.

## Reversing it

Because the stored content is never modified, you can undo everything by simply
unticking the filter (or removing a line) and saving — the original output returns.
