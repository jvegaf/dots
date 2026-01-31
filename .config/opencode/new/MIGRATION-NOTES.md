# OpenCode Agent Migration Notes

## Resumen de Cambios

Se han modificado todos los agentes en esta carpeta para hacerlos compatibles con OpenCode. Los cambios principales incluyen:

### 1. Estandarización del Frontmatter

**ANTES:**
```yaml
---
name: python-pro
model: github-copilot/claude-sonnet-4
tools:
  write: true
  edit: true
  read: true
---
```

**DESPUÉS:**
```yaml
---
name: python-pro
description: ...
mode: subagent
tools:
  - bash
  - read
  - write
  - edit
  - grep
  - glob
---
```

**Cambios:**
- Eliminado campo `model` (OpenCode maneja esto internamente)
- Añadido campo `mode: subagent` para uso con Task tool
- Convertido formato de tools de objeto a lista
- Solo herramientas nativas de OpenCode: bash, read, write, edit, grep, glob, list, task, todoread, todowrite, webfetch

### 2. Integración con AGENTS.md

Todos los agentes ahora incluyen una sección **IMPORTANT** que referencia las reglas doradas:

```markdown
**IMPORTANT**: Always follow the golden rules from AGENTS.md:
- Add/update `AIDEV-NOTE:` anchor comments near non-trivial edited code
- Never delete existing `AIDEV-` comments
- For changes >300 LOC or >3 files, ask for confirmation first
```

### 3. Eliminación de Protocolos JSON Complejos

**ANTES:**
```json
{
  "requesting_agent": "refactoring-specialist",
  "request_type": "get_refactoring_context",
  "payload": {
    "query": "Refactoring context needed..."
  }
}
```

**DESPUÉS:**
```markdown
When invoked:
1. Review code structure using read/grep tools
2. Analyze code smells and issues
3. Implement refactoring with safety guarantees
```

### 4. Reemplazo de Herramientas MCP Externas

**ANTES:**
```yaml
tools: ast-grep, semgrep, eslint, prettier, jscodeshift
```

**DESPUÉS:**
```yaml
tools:
  - bash
  - read
  - write
  - edit
  - grep
```

Con instrucciones para usar bash:
```markdown
## Tool Usage

Use bash tool for operations:
- `eslint/prettier`: Use bash with appropriate commands
- `AST transformations`: Use bash with language-specific tools
```

### 5. Simplificación de Progress Tracking

**ANTES:**
```json
{
  "agent": "refactoring-specialist",
  "status": "refactoring",
  "progress": {
    "methods_refactored": 156,
    "complexity_reduction": "43%"
  }
}
```

**DESPUÉS:**
```markdown
Progress tracking (internal notes):
- Methods refactored: track count
- Complexity reduction: measure improvement
```

### 6. Uso del Task Tool

Los agentes coordinadores ahora usan el Task tool de OpenCode:

```markdown
- Use Task tool to launch agents: general, tester, reviewer, debugger, code-reviewer, documentation, git-committer
- Launch multiple agents concurrently for maximum performance
```

### 7. Gestión de Proyectos Python

Todos los agentes Python ahora especifican:

```markdown
- Use `uv` for Python environment and package management (not pip)
```

## Archivos Modificados

1. **agent-organizer.md** - Coordinación multi-agente con Task tool
2. **architect-review.md** - Revisión arquitectónica
3. **context-manager.md** - Gestión de contexto con AIDEV- anchors
4. **context-manager-storage.md** - Gestión de almacenamiento de contexto (renombrado desde context-manager_1.md)
5. **error-detective.md** - Análisis de errores y logs
6. **git-workflow-manager.md** - Gestión de workflows Git
7. **knowledge-synthesizer.md** - Síntesis de conocimiento
8. **multi-agent-coordinator.md** - Coordinación distribuida
9. **performance-engineer.md** - Optimización de rendimiento
10. **php-pro.md** - Desarrollo PHP moderno
11. **prompt-engineer.md** - Ingeniería de prompts
12. **python-pro.md** - Desarrollo Python idiomático
13. **refactoring-specialist.md** - Refactorización segura
14. **search-specialist.md** - Búsqueda avanzada
15. **task-distributor.md** - Distribución de tareas
16. **test-automator.md** - Automatización de tests
17. **tooling-engineer.md** - Desarrollo de herramientas
18. **ui-designer.md** - Diseño de interfaces

## Compatibilidad con OpenCode

Los agentes ahora son compatibles con:

- ✅ Task tool para lanzar subagentes
- ✅ Herramientas nativas de OpenCode (bash, read, write, edit, grep, glob, etc.)
- ✅ Sistema de anchor comments AIDEV-NOTE/TODO/QUESTION
- ✅ Todo list management (todoread/todowrite)
- ✅ Reglas doradas de AGENTS.md
- ✅ Uso de uv para Python
- ✅ Uso de gh para GitHub operations

## Cómo Usar

Para usar estos agentes en OpenCode:

```markdown
# En tu conversación con OpenCode
@agent-organizer help me organize this complex task

# O con el Task tool
Use task tool with subagent_type="python-pro" to implement Python feature
```

## Notas Importantes

1. **Anchor Comments**: Los agentes ahora buscan activamente `AIDEV-*` anchors usando grep antes de modificar código
2. **Test Files**: Todos los agentes tienen restricción explícita de NO modificar tests sin permiso
3. **Confirmación**: Cambios grandes (>300 LOC o >3 archivos) requieren confirmación
4. **Secrets**: Prohibido commitear secrets - usar variables de entorno
5. **Git Config**: Prohibido modificar git config sin permiso

## Diferencias con Sistemas MCP

| Aspecto | Sistema MCP Original | OpenCode Compatible |
|---------|---------------------|---------------------|
| Tools | MCP tools externos | Herramientas nativas |
| Communication | JSON protocol | Prompt directo |
| Context Manager | Query-based | AIDEV- anchors |
| Multi-agent | Message queue | Task tool |
| Progress | JSON status | Internal notes |
| Model | Especificado | Manejado por OpenCode |

## Próximos Pasos

1. Probar cada agente individualmente con OpenCode
2. Ajustar descripciones según feedback de uso
3. Añadir más agentes según necesidades
4. Documentar patrones de uso comunes
