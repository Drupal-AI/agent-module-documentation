# Configuration

CKEditor5 Wiris has no dedicated Drupal settings form. Configuration is three
things: add the buttons to your text format(s), arrange for equations to render on
the front end, and sort out WIRIS licensing.

## 1. Add the MathType and ChemType buttons

1. Go to **Configuration → Content authoring → Text formats and editors**
   (`/admin/config/content/formats`).
2. **Configure** a format that uses CKEditor 5.
3. In the toolbar configuration, drag the **MathType** button (and **ChemType**,
   for chemical notation) from *Available buttons* into the *Active toolbar*.
4. Click **Save configuration**.

Editors will now see the buttons; clicking one opens the WIRIS visual editor, and
the equation is saved into the content as MathML.

## 2. Set up equation rendering (MathJax)

WIRIS produces MathML but **does not render it** on your published pages. Without a
renderer, visitors will see raw or unstyled markup instead of a formula. Install
and configure a MathML rendering solution — **MathJax** is the standard choice —
so equations display correctly across your themes.

When choosing how to render, decide between a **self-hosted** and a
**WIRIS-hosted** setup. The WIRIS-hosted option means equation rendering depends on
an external service reachable from your site — worth weighing for privacy, egress,
and availability, especially on sites with strict outbound-network policies.

## 3. Licensing

The module is free and open source, but **MathType and ChemType are commercial
WIRIS products and require a valid license.** Obtain and configure your license
through WIRIS — see <https://www.wiris.com/en/mathtype/> or contact
`sales@wiris.com`. The module integrates the products; it does not provide the
license.

If your rendering/license setup involves an API key or service token, keep it out
of version control: store it in an environment variable (for example with DDEV,
`ddev dotenv set .ddev/.env --wiris-key=<value>` then `ddev restart`) and reference
it through a Key entity or `getenv()` rather than hard-coding it in configuration.

## Save

There is no module settings form to save — the changes above are made in the text
format configuration, in your rendering module's settings, and with WIRIS. Clear
caches after adding the buttons if they do not appear immediately in the editor.
