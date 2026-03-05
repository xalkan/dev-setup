# AGENTS.md

> This guide is intended for coding agents (including AI agents) operating within the `dev-setup` repository. It contains strict safety boundaries, protocols, and best practices for Bash and shell scripting environments—whether enhancing this repo or working with projects set up by it.

---

## Repository Purpose
The repository automates installation and configuration for CachyOS (Arch-based systems) with a focus on:
- Bash & Zsh setup
- Kitty terminal
- VS Code integration

Agents may encounter or generate Bash, Shell, and Zsh scripts in projects managed by this setup.

---

## 🚨 Critical Safety & Permission Rules
1. **Read-Only by Default:** Agents may read and analyze files, but must not write, overwrite, or delete any file without presenting the proposed changes for review first.
2. **No Direct Execution:** Agents must not directly execute scripts, binaries, or commands that modify the system state (e.g., `rm`, `mv`, `chmod`, `curl | bash`) without explicit user confirmation.
3. **No Hidden Actions:** No background tasks, hidden git operations, or network requests without logging intent and awaiting approval.
4. **Confirmation Loop:** Every modification follows:
    - **Propose:** Explain the change and show the diff.
    - **Validate:** Check for potential breaking changes.
    - **Authorize:** Wait for user's explicit go-ahead.

---

## 🛠️ Git & Commit Protocol
- **Zero Auto-Commits:** Never run `git commit` or `git push` automatically. The user is the sole gatekeeper for history.
- **Manual Review Cycle:**
  1. Stage changes: `git add <file>`.
  2. Summarize to user.
  3. Wait for user's "commit" command.
- **Conventional Commits:** Use [Conventional Commits](https://www.conventionalcommits.org/) format:

| Type      | Purpose                           |
| --------- | ----------------------------------|
| **feat**  | New alias, function, config       |
| **fix**   | Syntax error or broken path fix   |
| **refactor**| Code structure improvement      |
| **style** | Formatting/comments update        |
| **docs**  | Updating README or comments       |
| **chore** | Maintenance (e.g., `.gitignore`)  |

**Format:** `<type>(<scope>): <description>`
*Example: `feat(shell): add fzf-based history search`*

---

## ⚡ Bash/Shell Scripting: Build, Lint, Test Commands
- **Linting:** `shellcheck <script.sh>`
- **Testing:** Manual; extract logic into testable functions.
- **Run Script:** `bash <script.sh>` or direct exec if shebang present.
- **Coverage:** Use `bashcov` if required.

---

## 💡 Clean Code & System Integrity - Bash/Shell
- **Safety Flags:** Use `set -e` and `set -u` in scripts.
- **Namespace Protection:** Prefix custom functions to avoid collisions with system commands.
- **Portability:** Target Bash 4.0+, prefer POSIX-compliant syntax for core utilities.
- **No Hardcoding:** Use `$HOME` instead of specific user paths.
- **Comments & Documentation:**
  - Every function must have a one-line comment.
  - Document complex regex or awk/sed usage.
- **Idempotency:** Scripts should be safe to run multiple times (e.g., append to `.bashrc` only if missing).
- **Symlink Management:** Use relative paths for symlinks.
- **Secrets Redaction:** Warn if plain text secrets detected; suggest `.secrets` file (in `.gitignore`).
- **Environment Detection:** Always check OS before OS-specific logic:
    ```bash
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS Logic
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux Logic
    fi
    ```

---

## 🖥️ Shell Aliases & Environment
- Provided by `.zshrc` after install (see setup.sh):
    - `z <dir>` — smart jump
    - `ls` — enhanced file listing
- Editor: VS Code is standard
- Font: FiraCode Nerd Font, default Kitty opacity: 0.85

---

## 📚 References & Further Reading
- [Google Shell Style Guide](https://google.github.io/styleguide/shellguide.html)

---

## 🗂️ Interaction Summary for Agents
> "I will analyze, propose, and draft. I will never commit, delete, or execute until you explicitly tell me to proceed. My goal is a clean, documented, and safe shell environment."

**Maintain strict style, run lint/tests before submitting any code. Document anything unusual.**

*If you encounter Copilot or Cursor rules files in future updates, merge their key rules into this document or link them here.*
