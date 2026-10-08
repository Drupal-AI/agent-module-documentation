# Configuration

There are two independent things to set up: **(1)** add the strength constraint to a Password
Policy (this is what enforces a minimum score), and **(2)** optionally tune which zxcvbn
matchers run site‑wide.

## 1. Add the Password Strength constraint to a policy

The strength check lives inside a **Password Policy**. Password Strength itself has no form
for the constraint — you configure it inside the policy.

1. Go to **Configuration → Security → Password Policy**
   (`/admin/config/security/password-policy`).
2. Click **Add policy** (or edit an existing one).
3. Work through the policy wizard. On the **Constraints** step, choose **Password Strength**
   and click **Configure Constraint Settings**.
4. Set the **minimum strength score** — an integer from **0** (very weak) to **4** (very
   strong). The default is **3**. A password must reach *at least* this score to be accepted;
   if it falls short, the user sees a message reporting both the score they achieved and the
   score required.
5. Finish the wizard, assigning the policy to one or more **roles**.

**Different rules for different people:** create more than one policy. For example, an "Admin"
policy requiring score 4 assigned to the administrator role, and a "Members" policy requiring
score 2 assigned to authenticated users. You can also stack the strength constraint alongside
other Password Policy constraints (minimum length, password history, and so on) in the same
policy.

## 2. Tune the zxcvbn matchers (site‑wide, optional)

Separately from the per‑policy score, you can control *how* zxcvbn scores passwords by turning
its individual weakness detectors ("matchers") on or off for the whole site.

1. Go to **Configuration → Security → Password Strength → Settings**
   (`/admin/config/security/password_strength/settings`). This form needs the *Administer
   site configuration* permission and is linked under the Password Policy admin area.
2. You'll see a checkbox for each of the eight built‑in matchers. All eight are **on by
   default**:
   - **Date match** — dates embedded in a password.
   - **Digit match** — three or more digits in a row.
   - **L33t match** — l33t‑speak substitutions (e.g. `p@ssw0rd`).
   - **Repeat match** — three or more repeated characters (e.g. `aaaaaa`).
   - **Sequence match** — alphanumeric sequences (e.g. `abcdef`, `123456`).
   - **Spatial match** — keyboard patterns (e.g. `qwerty`, `asdfgh`).
   - **Year match** — four‑digit years.
   - **Dictionary match** — common dictionary words.
3. Untick a matcher to stop it contributing to the score, then **Save**. Turning matchers off
   makes scoring more lenient; leaving them all on is the strictest and recommended setting.

This site‑wide setting affects every policy that uses the strength constraint.

## Verify it works

With a policy assigned to a role, log in as a user in that role and try to change the
password to something obviously weak — e.g. `password123` or your own username. The change
should be rejected with a message noting the score achieved versus the score required. Try a
strong passphrase and it should pass.
