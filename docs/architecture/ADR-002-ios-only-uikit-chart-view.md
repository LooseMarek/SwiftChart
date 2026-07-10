# ADR-002 — iOS-only, UIKit-based Chart View

**Date:** 2026-07-10
**Status:** Accepted
**Author:** Architect
**Deciders:** (inherited from pre-existing codebase, documented retroactively)

---

## Context

This decision predates the migration and is documented here retroactively so it's captured in
the same place all other architectural decisions live. `Source/Chart.swift` implements `Chart`
as a `UIControl` subclass, importing `UIKit` directly. `Package.swift` declares only
`.iOS(.v18)` as a supported platform.

---

## Decision

`Chart` remains a `UIKit`-based `UIControl` subclass, iOS-only. No cross-platform abstraction
(e.g. conditional `AppKit`/`UIKit` imports, or a SwiftUI-native rewrite) exists.

---

## Options Considered

### Option 1: UIKit `UIControl` subclass (chosen, inherited)

**Description:** Single concrete `UIControl` subclass drawn via `Core Graphics`/`UIBezierPath`
inside `draw(_:)`, configurable via `@IBDesignable`/`@IBInspectable`.

**Pros:**
- Simple, well-understood UIKit drawing model
- Works from both Interface Builder and code
- No cross-platform abstraction layer to maintain

**Cons:**
- No macOS/watchOS/tvOS/visionOS support without significant rework
- Not usable directly from SwiftUI without a `UIViewRepresentable` wrapper

### Option 2: SwiftUI-native chart view

**Description:** Rewrite as a SwiftUI `View` using `Canvas`/`Path`.

**Pros:**
- Native SwiftUI integration, works across all Apple platforms SwiftUI supports

**Cons:**
- Full rewrite of the rendering and touch-handling logic
- Breaking change for all existing consumers using the `UIControl`-based API

---

## Rationale

This was the original implementation choice inherited from the upstream project and has not
been revisited as part of this migration — changing it is a product/API decision, not a
structural one, and is out of scope for `migrate-existing-project`.

---

## Consequences

**Positive:**
- Existing consumers' integration code continues to work unchanged

**Negative / Trade-offs:**
- Library cannot be used on macOS/visionOS without a port
- No SwiftUI-native usage without a wrapper

**Risks:**
- None introduced by this migration — behavior is unchanged from before

---

## Related

| Type | Reference |
|------|-----------|
| Supersedes | |
| Related ADRs | ADR-000 |
| Related issues | |
