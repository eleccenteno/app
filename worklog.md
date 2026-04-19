# Work Log - Electrónica Centeno Preventive Maintenance App

## Date: 2026-04-18

### Summary
Built a complete preventive maintenance web application for "Electrónica Centeno" using Next.js 16, TypeScript, Tailwind CSS, shadcn/ui, Prisma ORM, and Zustand state management. Fixed frontend issues and verified backend functionality.

### Files Created/Modified

#### Database (Prisma)
- `prisma/schema.prisma` — Updated with Employee, Preventivo, FotoPreventivo, Centro, Empresa, SubEmpresa, Tarea, Vehiculo models
- `prisma/seed.ts` — Full seed script with empresas, sub-empresas, empleados, centros, vehiculos, preventivos, tareas
- `src/lib/db.ts` — Prisma client with optimized logging (warn/error only)

#### API Routes
- `src/app/api/auth/login/route.ts` — POST endpoint for employee authentication
- `src/app/api/employees/route.ts` — GET/POST/PUT endpoints for employees with cross-referenced data
- `src/app/api/preventivos/route.ts` — GET/POST/PUT endpoints for preventivos with photos and filters
- `src/app/api/centros/route.ts` — GET/POST/PUT endpoints for centros with advanced filtering
- `src/app/api/estadisticas/route.ts` — GET endpoint for cross-referenced statistics
- `src/app/api/empresas/route.ts` — GET endpoint for empresas
- `src/app/api/subempresas/route.ts` — GET endpoint for sub-empresas
- `src/app/api/tareas/route.ts` — GET/POST endpoints for tareas
- `src/app/api/vehiculos/route.ts` — GET endpoint for vehiculos

#### State Management
- `src/lib/store.ts` — Zustand store managing auth, navigation, preventivo form data, and UI state

#### Components
- `src/components/LoginForm.tsx` — Login screen with API-backed authentication
- `src/components/Sidebar.tsx` — Desktop sidebar navigation with user info and logout
- `src/components/BottomNav.tsx` — Mobile bottom navigation bar
- `src/components/DashboardHeader.tsx` — Sticky header with navigation history support
- `src/components/InicioView.tsx` — Home view with 3 company cards (Cellnex, Insyte, Centeno)
- `src/components/CellnexView.tsx` — Cellnex sub-company grid (Ontower, Retevision, Axion, Gamesystem)
- `src/components/OntowerView.tsx` — Ontower 12-icon function grid
- `src/components/PreventivosForm.tsx` — Multi-step form (4 steps) with API integration
- `src/components/PhotoCapture.tsx` — Camera/file photo capture with preview
- `src/components/LocationPicker.tsx` — GPS geolocation with error handling
- `src/components/PanelControl.tsx` — Control panel grid
- `src/components/PlaceholderView.tsx` — Placeholder for sections in development
- Plus: InsyteView, CentenoView, RetevisionView, AxionView, GamesystemView, ServicioTecnico

### Database Seed Data
- **3 Empresas**: Cellnex, Insyte, Electrónica Centeno
- **4 Sub-empresas**: OnTower, Retevision, Axion, GameSystem (under Cellnex)
- **7 Empleados**: toni/123 (admin), curro/123, erika/123, moises/123, miguel/123, paco/123, fran/123
- **15 Centros**: Distributed across all empresas/sub-empresas
- **3 Vehículos**: Nissan X-Trail, Renault Kangoo, Peugeot Partner
- **3 Preventivos**: Example data across different centros
- **3 Tareas**: Example tasks with different priorities

### Key Features
1. **Login** — API-backed authentication against Prisma database
2. **Hierarchical Navigation** — Inicio → Empresa → Sub-empresa → Functions
3. **Preventivos Form** — Multi-step with photo capture, GPS, and API save
4. **Backend CRUD** — Full CRUD for centros, preventivos, empleados, tareas
5. **Cross-referenced Statistics** — Data filtering by empresa, sub-empresa, técnico
6. **Responsive Design** — Mobile-first with sidebar (desktop) and bottom nav (mobile)

---
Task ID: 5
Agent: full-stack-developer
Task: Create DatosCentrosView component for center data display

Work Log:
- Created DatosCentrosView.tsx with list view and detail view
- List view includes search bar, filters (provincia, prioridad, tipo_centro), paginated card list
- Detail view has horizontal scrollable tab bar with all 14 sections
- Implemented admin-only editing with Input fields and Save button
- Non-admin users see read-only display with lock icon and tooltip
- Subsection headers (MAQUINA PRINCIPAL, EQUIPOS EXTERIORES, etc.) displayed as styled dividers
- Prioridad badges: P1=red, P2=amber, P3=green
- Updated OntowerView.tsx: changed datos-centros funcional from false to true
- Updated page.tsx: imported DatosCentrosView and replaced PlaceholderView in switch case

Stage Summary:
- DatosCentrosView component created with all 14 sections
- Admin users (role='admin') can edit fields with save functionality, others see read-only
- List view has search, 3 filter dropdowns, pagination with "Cargar más" button
- Detail view has horizontal scrollable tabs with 2-column grid layout
- Subsection headers rendered as styled dividers within tab content
- Lint passes with no errors

---
Task ID: usuarios-crud
Agent: full-stack-developer
Task: Create Users Management View (UsuariosView) for Electrónica Centeno App

Work Log:
1. **Updated prisma/seed.ts** — Replaced 7 basic employee records with all 26 real users from the Excel data. Each user now includes nombreCompleto, tipo, dni, phone, vehiculoMarca, vehiculoModelo, vehiculoMatricula. Passwords updated per spec (toni/123 kept, curro/Fjavierl007, erika/By_eriika01, etc.)

2. **Updated src/app/api/employees/route.ts** — Added DELETE handler (soft delete/deactivate), updated GET select to include nombreCompleto, tipo, vehiculoMarca, vehiculoModelo, vehiculoMatricula, foto fields. Updated POST to accept all new fields. Updated PUT to handle empty password (skip update).

3. **Updated src/lib/store.ts** — Added 'usuarios' to ViewType union type.

4. **Created src/components/UsuariosView.tsx** — Comprehensive 'use client' component with:
   - Users table (desktop) / card list (mobile) showing status indicator, name, username, email, phone, tipo badge, DNI, vehicle info
   - Search bar filtering by name, email, username, DNI
   - Filter dropdowns: Tipo (5 options + todos), Estado (Activo/Inactivo/Todos)
   - Stats cards: Total, Active, Inactive counts
   - Create User Dialog (admin only) with full form: name, nombreCompleto, username, password, email, phone, dni, tipo, vehicle fields
   - Edit User Dialog (admin only) with pre-filled data, password shows placeholder only
   - Toggle Active/Inactive with confirmation AlertDialog
   - Delete (soft delete) with confirmation AlertDialog
   - Non-admin banner: "Solo los administradores pueden gestionar usuarios"
   - Role auto-assigned based on tipo selection
   - Responsive design: table on desktop, cards on mobile
   - Teal color scheme, shadcn/ui components throughout

5. **Updated src/app/page.tsx** — Added UsuariosView import and 'usuarios' case in switch statement.

6. **Updated src/components/Sidebar.tsx** — Added Users icon import and "Usuarios" nav button visible only to admin users (currentUser?.role === 'admin').

7. **Ran prisma db push** — Schema already in sync, Prisma Client regenerated.
8. **Ran seed** — Successfully created all 26 employees, verified in output.
9. **Lint** — Passes with no errors.

Stage Summary:
- Full CRUD user management view implemented
- 26 real users seeded with complete profile data
- Admin-only creation, editing, toggle, and soft-delete functionality
- Non-admin users can view but not modify
- Responsive design with professional teal-themed UI
- API fully supports new Employee fields
---
Task ID: preventivos-form
Agent: main
Task: Implement comprehensive Preventivos form with all 14 sections and 130+ fields

Work Log:
- Read existing project structure and files (PreventivosForm, store, page.tsx, OntowerView)
- Designed form schema with 14 sections matching user's specification exactly
- Created /src/lib/preventivo-schema.ts with all sections, fields, types, and enum options
- Updated /src/lib/store.ts with new dynamic form data structure (Record<string, string> for fields, section-based photos)
- Rewrote /src/components/PreventivosForm.tsx with comprehensive form:
  - 14 horizontal scrollable tabs for sections
  - Dynamic field rendering based on type (Text, Number, Decimal, Enum, EnumList, LongText, Phone, Date, LatLong)
  - Centro selector with search functionality (pulls from 360 centros)
  - GPS location capture
  - Photo capture per section
  - Subsections within A.A (Maquina Principal, Secundaria, Contingencia, Sondas, Extraccion) and Coubicados (Exteriores, Interiores)
  - EnumList multi-select with checkbox UI
  - Field completion progress per section
  - Save/Submit with validation
- Added "Usuarios" option to OntowerView menu
- Cleaned up unused code (renderSectionPhotos with hooks violation)
- Verified TypeScript compilation passes with no errors

Stage Summary:
- Complete PreventivosForm with 14 sections and 130+ fields implemented
- Form schema: /src/lib/preventivo-schema.ts
- Updated store: /src/lib/store.ts
- Form component: /src/components/PreventivosForm.tsx
- UsuariosView was already implemented from previous session
- Added Usuarios to OntowerView navigation
---
Task ID: form-editor
Agent: main
Task: Implement comprehensive form editor in Panel de Control for Preventivos form

Work Log:
- Updated preventivo-schema.ts with VisibilityCondition, ConditionOperator types and visible/conditions/conditionLogic fields on FormField, FormSubsection, FormSection
- Added helper functions: evaluateCondition, isVisible, getAllEnumFields, cloneSections
- Created schema-store.ts (Zustand) with localStorage persistence for custom schema
- Full CRUD operations: add/update/remove fields, sections, subsections
- Enum options management: add/edit/delete/reorder
- Condition management: add/remove/update conditions and logic (AND/OR)
- Field reordering (move up/down), section reordering, visibility toggles
- Created FormEditorView.tsx with comprehensive visual editor:
  - Section-level management (expand/collapse, reorder, hide/show, delete)
  - Field rows with type badges, required/hidden/conditional badges
  - Quick actions: move up/down, toggle required, toggle visibility, edit, delete
  - Add field dialog with type selector and enum options
  - Field editor dialog with:
    - Label, type, placeholder editing
    - Enum options editor (add, edit inline, delete, reorder)
    - Conditional visibility editor (add conditions, select enum fields, operators, values)
  - Add section and add subsection dialogs
  - Export schema to JSON, reset to default
  - Stats dashboard (sections, fields, hidden, conditional)
- Updated PreventivosForm.tsx to use custom schema from schema-store
- Applied visibility filtering on sections, subsections, and fields using isVisible()
- Shows "section hidden" message when conditions hide a section
- Updated PanelControl.tsx with "Editor Formulario" card linking to form-editor view
- Updated store.ts with 'form-editor' ViewType
- Updated page.tsx with FormEditorView import and routing

Stage Summary:
- Complete form editor accessible from Panel de Control > Editor Formulario
- Can add/remove/move/edit fields and sections
- Can edit enum options (add, edit, delete, reorder)
- Can set conditional visibility (e.g., hide AA section when centro is Outdoor)
- Schema persisted in localStorage, can be exported to JSON or reset to default
- PreventivosForm respects custom schema and conditional visibility in real-time

---
Task ID: editor-submenu + visor-preventivos
Agent: main
Task: Restructure Editor as submenu in Panel de Control, and add Visor Preventivos icon in OntowerView

Work Log:
- Added 'editor' and 'visor-preventivos' to ViewType union in store.ts
- Created EditorView.tsx - submenu page for editors with cards for "Formulario Preventivos" (active) and future editors (Vehículos, Tareas, Servicio Técnico - marked as "Próximamente")
- Updated PanelControl.tsx - "Editor" card now navigates to 'editor' view instead of directly to 'form-editor', updated badge check
- Updated FormEditorView.tsx - back button now navigates to 'editor' instead of 'panel-control'
- Added "Visor Preventivos" icon (Eye icon, indigo color) in OntowerView.tsx with funcional: true
- Created VisorPreventivosView.tsx - comprehensive viewer for completed preventivos with:
  - Stats dashboard (total, pendientes, completados, enviados)
  - Search bar (by centro, técnico, procedimiento, ciudad)
  - Filter by estado (todos, borrador, pendiente, en_progreso, completado, enviado)
  - Card list with status icon, centro name, badges, fecha, técnico, ciudad, fotos count
  - Detail dialog showing: status, centro info, metadata grid, datos del preventivo, observaciones, schema sections expansion, photo gallery
  - Fetches from /api/preventivos API endpoint
- Updated page.tsx - imported EditorView and VisorPreventivosView, added 'editor' and 'visor-preventivos' routing cases
- TypeScript compilation passes with no errors in src/

Stage Summary:
- Editor is now a submenu with room for future editors (Vehículos, Tareas, Servicio Técnico)
- "Visor Preventivos" icon available in OntowerView grid
- VisorPreventivosView fetches and displays preventivos from the API with search, filter, and detail view

---
Task ID: schema-rewrite
Agent: main
Task: Rewrite preventivo-schema.ts with correct form fields, add Show/Ref/Image types

Work Log:
- Completely rewrote preventivo-schema.ts with 17 sections matching user's correct specification
- Added 3 new field types: Show (display-only text), Ref (auto-filled reference), Image (individual photo capture)
- Sections: General, Procedimientos Preventivos, Infraestructura, Torre, Equipos Exteriores, Vallado y Terreno, Equipos Interiores, Cuadro Eléctrico, EVCC, Remota, Enlaces, Aire Acondicionado (with 4 subsections), Extracción, Sigfox, Fotovoltaica, Limpieza, Observaciones
- ~400+ fields total including all Image fields, Show instructions, Show headers, category labels
- Updated PreventivosForm.tsx: added rendering for Show (styled text with different styles for instructions, notes, headers, categories), Ref (read-only with AUTO badge), Image/Photo (capture/upload with preview and delete)
- Updated icon map to include Shield, Wind, Sparkles, ClipboardList for new section icons
- Updated FormEditorView.tsx: added Show, Ref, Image to FIELD_TYPES array with descriptive labels
- TypeScript compilation passes with no errors in src/

Stage Summary:
- Complete schema rewrite with correct 17-section structure
- New field types: Show (display text), Ref (auto-fill), Image (individual photo)
- Form editor supports all 13 field types
- Form renders all field types including inline photo capture

---
Task ID: prefill-preventivo-from-centros
Agent: main
Task: Pre-fill preventivo form fields from Datos Centros when a centro is selected

Work Log:
- Analyzed existing PreventivosForm.tsx handleSelectCentro (only filled 5 basic fields)
- Analyzed Datos Centros JSON data structure (14 sections, 180 fields per centro)
- Analyzed Preventivo form schema (399 fields total)
- Created comprehensive mapping file: src/lib/centro-to-preventivo-map.ts with 157 field mappings across all sections
- Updated PreventivosForm.tsx:
  - Added centrosFullData state to store full centro data indexed by codigo
  - Imported and used getCentroPreFillData() mapping function
  - handleSelectCentro now pre-fills ALL matching fields from Datos Centros
  - Added prefilledFields state tracking which fields were auto-filled
  - Added toast notification showing count of pre-filled fields
  - Added visual "DC" badge on pre-filled field labels (blue background)
  - Added blue border/ring styling on pre-filled input fields
  - Added header badge showing total pre-filled count
- Verified TypeScript compilation clean (no errors)

Stage Summary:
- Created src/lib/centro-to-preventivo-map.ts with 157 field mappings
- When a centro is selected in preventivo form, all matching fields auto-fill from Datos Centros
- Pre-filled fields are visually distinguished with blue "DC" badge and blue border
- Sections covered: General, Suministro Eléctrico, Remota, EVCC, A/A (Principal+Secundaria+Contingencia+Sondas+Extracción), Torre, GameSystem, Nidos, Infraestructura, Coubicados, Cuadro Eléctrico, Enlaces, Sigfox, Fotovoltaica

---
Task ID: 1
Agent: Main Agent
Task: Crear Editor de Datos Centros en Panel de Control → Editor

Work Log:
- Exploré la estructura completa: EditorView.tsx, FormEditorView.tsx, sections_config.json, store.ts, schema-store.ts, preventivo-schema.ts
- Creé `/src/lib/centros-schema.ts` - Convierte sections_config.json (formato columns[]) al formato FormSection/FormField del editor, con todas las opciones de enum adecuadas por campo (~180 campos en 14 secciones)
- Creé `/src/lib/centros-schema-store.ts` - Store Zustand independiente para CRUD del esquema de centros, con persistencia en localStorage (key: `ec_centros_custom_schema`)
- Creé `/src/components/CentrosEditorView.tsx` - Componente completo de editor de datos centros con: secciones expandibles, filas de campo con acciones (mover, ocultar, editar, eliminar), diálogo de edición de campo, diálogo de añadir campo, diálogo de añadir sección, diálogo de añadir subsección, editor de opciones enum, editor de visibilidad condicional
- Actualicé `/src/lib/store.ts` - Añadido `'centros-editor'` al ViewType union
- Actualicé `/src/components/EditorView.tsx` - Añadida tarjeta "Datos Centros" con icono Database, color azul, funcional=true
- Actualicé `/src/app/page.tsx` - Añadido import CentrosEditorView y routing para 'centros-editor'
- Verificación: `npx next build` compiló exitosamente

Stage Summary:
- Editor de Datos Centros completamente funcional accesible desde Panel de Control → Editor → Datos Centros
- Tema visual azul (diferenciado del verde del editor de preventivos)
- Tipos de campo soportados: Text, Number, Decimal, Enum, EnumList, LongText, Phone, Date, LatLong, Show
- Persistencia en localStorage independiente del editor de preventivos
- Funcionalidades: añadir/editar/eliminar/mover secciones y campos, editar opciones de enum, visibilidad condicional, exportar JSON, restaurar valores por defecto

---
Task ID: 2
Agent: Main Agent
Task: Corregir campos DC que no se importan del formulario preventivo desde datos centros

Work Log:
- Analicé el flujo completo de pre-fill: PreventivosForm → handleSelectCentro → getCentroPreFillData → setPreventivoField
- Descubrí el problema raíz: los valores del JSON de datos centros están en formatos diferentes a las opciones Enum del preventivo
- Mismatches encontrados: "INDOOR" vs "Indoor", "Si" vs "Sí", "BADAJOZ" vs "Badajoz", "ELTEK" vs "Sí - Eltek", "CELLNEX" vs "Cellnex", etc.
- El valor SE guardaba en el store, pero el componente Select no lo mostraba porque no coincidía con ninguna opción
- Solución implementada en dos capas:
  1. Normalización inteligente en getCentroPreFillData: compara case-insensitive y accent-insensitive contra las opciones del form
  2. Fallback en el componente Enum del PreventivosForm: si el valor no coincide con ninguna opción, muestra un Input editable con botón X para limpiar y usar el selector
- Añadidos campos que faltaban en el mapeo: telefonoComercializadora (col_12), contactoComercializadora (col_13)
- Build exitoso, test de normalización con 11/12 passes (el caso "Correcto" vs "Buen estado" es conceptualmente diferente y se maneja con el fallback)

Stage Summary:
- Archivo principal modificado: `/src/lib/centro-to-preventivo-map.ts` — Normalización inteligente de valores
- Archivo modificado: `/src/components/PreventivosForm.tsx` — Enum fallback para valores no-matching
- La normalización resuelve ~90% de los casos automáticamente (case, accents)
- El fallback del Enum muestra valores no-matching como texto editable con botón para limpiar

---
Task ID: photo-storage-system
Agent: Main Agent
Task: Implement photo storage system for preventivos with folder structure and compression

Work Log:
- Analyzed existing infrastructure: image-compress.ts (unused), /api/fotos-preventivo/upload (unused), /api/fotos-preventivo/file (unused), PhotoCapture.tsx (unused)
- Identified that photos were stored as raw base64 in form fields - very inefficient
- Integrated compressImage() from image-compress.ts into PreventivosForm
- Created handlePhotoCapture() function: compress → upload via API → store API path instead of base64
- Created handlePhotoDelete() function: deletes from server filesystem via DELETE API
- Updated Image/Photo field rendering: loading spinner during upload, "Servidor" badge for server-stored photos
- Photo capture requires centro selection before enabling (folder structure depends on centro info)
- Updated SectionPhotoManager with same compress + upload flow
- Fixed upload API: replaced require('fs/promises') with proper import
- All photos now saved to: fotografias preventivos atw/{year}/{provincia}/{centroNombre} - {centroCodigo}/{fieldLabel}.jpg
- Images compressed to max 1MB using progressive quality reduction and canvas resizing
- Backward compatible: still displays old base64 values correctly

Stage Summary:
- Photos now saved to filesystem with proper folder structure instead of embedded base64
- Image compression integrated (max 1MB per photo)
- Server API endpoints for upload/delete now fully connected
- Form save payload is much smaller (API paths instead of base64 strings)
- Build successful with no errors

---
Task ID: photo-delete-button
Agent: main
Task: Añadir botón de eliminar foto visible y botón de repetir foto en preventivos

Work Log:
- Analizado PreventivosForm.tsx: el botón de eliminar existía pero estaba oculto con `opacity-0 group-hover:opacity-100`, inaccesible en dispositivos táctiles
- Añadido import de `RotateCcw` icon
- Modificado el case Image/Photo: reemplazado overlay hover por botones siempre visibles debajo de la foto
- Botón "Repetir" (RotateCcw): elimina la foto anterior del servidor y abre cámara/galería para reemplazarla
- Botón "Eliminar" (Trash2): elimina la foto y muestra toast de confirmación
- Mejorado SectionPhotoManager: botón delete ahora usa icono Trash2, tamaño h-7 para mejor touch, toast de confirmación al eliminar
- Build verificado exitosamente

Stage Summary:
- Botones siempre visibles (no dependen de hover) — funciona en PC y Android
- "Repetir" elimina la foto vieja del servidor antes de subir la nueva
- "Eliminar" borra del servidor y limpia el campo, con toast de confirmación
- SectionPhotoManager también mejorado con toast y mejor touch target

---
Task ID: install-guide-pdf
Agent: main
Task: Crear guía paso a paso de instalación en Ubuntu Server en formato PDF

Work Log:
- Analizada la estructura completa del proyecto Next.js para crear guía precisa
- Generada paleta de colores con palette.cascade para el documento
- Escrito script Python con ReportLab para generar PDF profesional
- 13 secciones: Requisitos, Preparación, Node.js/Bun, Instalación, BD, Compilación, Caddy, Firewall, Fotografías, Systemd, Verificación, Mantenimiento, Solución de Problemas
- PDF generado exitosamente: 15 páginas, 90.6 KB
- QA: 10 checks passed, 2 minor warnings (cover not full-bleed by design, TOC margin cosmetic)

Stage Summary:
- Archivo generado: /home/z/my-project/download/Guia_Instalacion_Ubuntu_Server_Electronica_Centeno.pdf
- 15 páginas con portada, índice, y 13 secciones detalladas
- Incluye tablas de requisitos, comandos de instalación, configuración de servicios
- Guía completa en español para Ubuntu Server
---
Task ID: offline-support
Agent: main
Task: Implement offline support for preventivos form (autosave, drafts, photo queue, sync)

Work Log:
- Created /src/lib/offline-storage.ts — full offline storage utility with draft management, pending submissions queue, offline photo queue, storage stats
- Created /src/hooks/useOfflineSync.ts — React hooks for online status, autosave (2s debounced), draft management, and offline sync with auto-retry
- Modified PreventivosForm.tsx:
  - Added online/offline detection with visual indicator (Wifi/WifiOff badges)
  - Added autosave indicator (Cloud badge showing last save time)
  - Added pending sync count indicator
  - Added offline mode banner with clear instructions
  - Added draft recovery dialog on mount
  - Added syncing progress banner with progress bar
  - Modified handleSave to support offline mode (queue to localStorage when no connection)
  - Modified handlePhotoCapture to save base64 locally when offline
  - Changed button labels when offline ("Guardar local" / "Enviar (sin conexión)")
  - Added manual sync button when there are pending submissions
  - Skip duplicate check when in offline mode (can't verify without server)
- Build compiled successfully

Stage Summary:
- Full offline-first architecture implemented
- Data never lost: autosave every 2 seconds to localStorage
- Photos stored as base64 locally when offline, uploaded when connection returns
- Pending submissions auto-sync when coming back online
- Draft recovery on app load
- Visual indicators for all states (online/offline, saving, syncing, pending)
---
Task ID: import-preventivos-2026
Agent: main
Task: Integrar preventivos 2026 desde Excel a la aplicación

Work Log:
- Leído y analizado archivo Excel con 90 preventivos y 448 columnas
- Identificado problema crítico: el modelo Preventivo de Prisma solo tenía ~10 columnas, perdiéndose los 200+ campos del formulario
- Añadida columna `formData` (String/JSON) al modelo Preventivo en schema.prisma
- Actualizada API de preventivos (POST/PUT/GET) para serializar/deserializar formData
- Creado mapeo completo de 448 columnas Excel → field keys del formulario (448 mapeos)
- Creado script de importación `scripts/import-preventivos.ts` con:
  - Parseo robusto de fechas (múltiples formatos)
  - Normalización de valores (Sí/No, tipos de línea, alimentaciones, etc.)
  - Auto-creación de centros si no existen
  - Auto-creación de técnicos si no existen
  - Detección de duplicados (actualiza formData si ya existe)
  - Imágenes omitidas según instrucción del usuario
- Ejecutada importación: 88 creados, 2 duplicados actualizados, 0 errores
- Verificados datos: campos correctamente mapeados y almacenados

Stage Summary:
- 88 preventivos de 2026 importados exitosamente
- 88 centros creados en la BD
- 6 técnicos creados (Fran, Curro, Enrique, etc.)
- Columna `formData` almacena ~50-110 campos por preventivo (sin imágenes)
- Build exitoso
---
Task ID: sidebar-accessibility
Agent: main
Task: Añadir modo día/noche y control de tamaño de letra al menú lateral

Work Log:
- Exploré el sidebar actual (Sidebar.tsx), store (store.ts), CSS (globals.css), layout.tsx y ThemeInitializer.tsx
- Añadí `darkMode: boolean` y `fontSizeLevel: FontSizeLevel` al Zustand store con persistencia en localStorage
- Añadí acciones: setDarkMode, toggleDarkMode, setFontSizeLevel, increaseFontSize, decreaseFontSize
- Actualicé ThemeInitializer.tsx para aplicar clase `.dark` y `font-size-{level}` al <html>
- Actualicé layout.tsx inline script para aplicar dark mode y font size al cargar (evitar flash)
- Añadí CSS en globals.css: `html.dark` override variables + `html.font-size-normal/large/xlarge` font-size scaling
- Rediseñé el sidebar con nueva sección "Accesibilidad" que incluye toggle día/noche con switch animado y control de tamaño de letra con botones +/-

Stage Summary:
- Modo día/noche funciona independientemente del tema de colores (Océano en dark, Volcán en dark, etc.)
- Tamaño de letra: 3 niveles (normal 16px, large 18px=112%, xlarge 20px=125%)
- Ambos controles son inline en el sidebar (no requieren navegar a otra vista)
- Persistencia en localStorage: app-dark-mode, app-font-size
- Prevención de flash con inline script en <head>
---
Task ID: redesign-all-menus
Agent: main
Task: Rediseño completo de todos los menús, submenús y barras de navegación con diseño moderno premium

Work Log:
- Leí todos los 12 componentes de navegación y menús existentes
- Rediseñé Sidebar.tsx: gradientes en logo, iconos empresa con fondo colorido, separadores con gradiente, secciones con tracking letterspacing, toggle dark mode animado, control font size con bordes
- Rediseñé BottomNav.tsx: backdrop-blur-xl, indicador activo en top, iconos con scale animation, padding en active state
- Rediseñé DashboardHeader.tsx: gradiente en logo, avatar con ring, dropdown mejorado con info de rol y shield icon, responsive
- Rediseñé InicioView.tsx: hero con badge, tarjetas con gradient top bar, hover con flecha animada, descripciones, stat labels
- Rediseñé CellnexView.tsx: header con gradiente icon, tarjetas horizontales con icon+info, estadísticas, hover animations
- Rediseñé OntowerView.tsx: separación clara "Módulos Activos" vs "Próximamente", grid 4 cols, gradientes por módulo, lock icon en inactivos
- Rediseñé PanelControl.tsx: gradiente cards, badge "Activo" con gradiente, misma estética que el resto
- Rediseñé InsyteView, CentenoView, RetevisionView, AxionView, GamesystemView: diseño consistente con gradiente del color de empresa, lock icon, "Próximamente" badge
- Rediseñé PlaceholderView.tsx: genérico con props para gradiente e icon personalizado

Stage Summary:
- Todos los componentes compilados sin errores
- Diseño coherente: gradientes top bar, iconos con gradiente de marca, shadows coloridas, hover animations suaves
- Separadores con gradiente en sidebar, separación visual clara entre secciones
- OntowerView divide activos/inactivos visualmente
- Todas las empresas placeholder tienen su color de marca consistente

---
Task ID: import-tareas-excel
Agent: main
Task: Import Excel tareas data into the Tareas module and update schema/visor to match Excel column values

Work Log:
- Analyzed Excel file "Tareas pendientes.xlsx": 308 rows, 27 columns
- Compared Excel columns vs existing Tarea schema and documented all differences
- Updated tarea-schema.ts enums: Provincia (Badajoz/Cáceres), TipoCentro (INDOOR/OUTDOOR), Prioridad (P1/P3/P3 AIRE), Proyecto (BABEL/BABIECA/BUENAVISTA), EstadoTarea (Pendiente/Realizado), TipoTarea (38 types from Excel), PrioridadTarea (Green/Yellow/Red)
- Updated VisorTareasView: COLOR_MAP now supports Green/Yellow/Red, getEstadoConfig supports Pendiente/Realizado (Excel values), Stats dashboard shows Realizadas/Pendientes, Filter dropdown updated
- Added missing employees to database: Adrian, Lewish, Pedro
- Created Python import script (scripts/import_tareas.py) that reads Excel and inserts into SQLite
- Executed import: 308 tareas imported, 0 skipped, 0 errors
- Verified data: 102 Pendiente, 206 Realizado, all formData fields populated correctly
- Build successful

Stage Summary:
- 308 tareas from Excel fully imported into database
- Schema and visor updated to match Excel field values exactly
- Employees Adrian, Lewish, Pedro added to Employee table
- Import script at scripts/import_tareas.py for future re-imports

---
Task ID: fix-tareas-api-error
Agent: main
Task: Fix VisorTareas API error showing 0 tasks

Work Log:
- Diagnosed API returning {"error":"Error al obtener tareas"} 
- Root cause 1: DateTime fields in SQLite had format "2024-02-07" (date-only) instead of ISO "2024-02-07T00:00:00.000Z" - Prisma couldn't parse them
- Root cause 2: formData was being lost during API serialization due to Prisma getter properties not being materialized by spread operator
- Fixed DateTime format: Updated 307 fechaLimite and 308 createdAt/updatedAt rows to proper ISO format
- Fixed formData serialization: Changed from manual Object.entries iteration to JSON.parse(JSON.stringify(t)) which materializes all Prisma properties
- Removed debug console.log after verification
- Verified: 308 tareas now load correctly with full formData (provincia, tipoTarea, prioridadTarea, etc.)

Stage Summary:
- API /api/tareas now returns 308 tareas with complete formData
- PrioridadTarea distribution: Green(139), Red(55), Yellow(40), vacío(74)
- Estado distribution: Pendiente(102), Realizado(206)
- Build successful
