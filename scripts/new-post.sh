#!/bin/bash

# =============================================================================
# new-post.sh - Crea un nuevo post formateado para el blog de carluve.dev
# =============================================================================
#
# USO:
#   ./scripts/new-post.sh <archivo_markdown> [carpeta_imagenes]
#
# EJEMPLOS:
#   ./scripts/new-post.sh ~/Desktop/mi-post.md
#   ./scripts/new-post.sh ~/Desktop/mi-post.md ~/Desktop/imagenes-post/
#
# El script:
#   1. Lee el markdown original
#   2. Extrae o genera el frontmatter necesario
#   3. Copia las imágenes a public/assets/img/YEAR/MONTH/
#   4. Actualiza las rutas de imágenes en el markdown
#   5. Crea el post en src/content/blog/YEAR/
#
# =============================================================================

set -e

# Colores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Directorio base del proyecto
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Función para mostrar uso
show_usage() {
    echo -e "${BLUE}Uso:${NC} $0 <archivo_markdown> [carpeta_imagenes]"
    echo ""
    echo "Argumentos:"
    echo "  archivo_markdown   Ruta al archivo .md con el contenido del post"
    echo "  carpeta_imagenes   (Opcional) Carpeta con las imágenes del post"
    echo ""
    echo "Ejemplo:"
    echo "  $0 ~/Desktop/mi-post.md ~/Desktop/imagenes/"
    exit 1
}

# Función para generar slug desde título
slugify() {
    echo "$1" | \
        iconv -t ascii//TRANSLIT | \
        sed -E 's/[^a-zA-Z0-9]+/-/g' | \
        sed -E 's/^-+|-+$//g' | \
        tr '[:upper:]' '[:lower:]'
}

# Función para obtener el mes en inglés
get_month_name() {
    case $1 in
        01) echo "january" ;;
        02) echo "february" ;;
        03) echo "march" ;;
        04) echo "april" ;;
        05) echo "may" ;;
        06) echo "june" ;;
        07) echo "july" ;;
        08) echo "august" ;;
        09) echo "september" ;;
        10) echo "october" ;;
        11) echo "november" ;;
        12) echo "december" ;;
    esac
}

# Verificar argumentos
if [ $# -lt 1 ]; then
    show_usage
fi

INPUT_FILE="$1"
IMAGES_FOLDER="${2:-}"

# Verificar que el archivo existe
if [ ! -f "$INPUT_FILE" ]; then
    echo -e "${RED}Error:${NC} El archivo '$INPUT_FILE' no existe"
    exit 1
fi

echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}📝 Nuevo Post para carluve.dev${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Leer contenido del archivo
CONTENT=$(cat "$INPUT_FILE")

# Detectar si ya tiene frontmatter
HAS_FRONTMATTER=false
if echo "$CONTENT" | head -1 | grep -q "^---"; then
    HAS_FRONTMATTER=true
    echo -e "${GREEN}✓${NC} Frontmatter detectado en el archivo"
fi

# Extraer o pedir título
if $HAS_FRONTMATTER; then
    TITLE=$(echo "$CONTENT" | grep -E "^title:" | head -1 | sed 's/title:[[:space:]]*//' | sed 's/^["'"'"']//' | sed 's/["'"'"']$//')
fi

if [ -z "$TITLE" ]; then
    echo -e "${YELLOW}?${NC} Introduce el título del post:"
    read -r TITLE
fi

echo -e "${GREEN}✓${NC} Título: $TITLE"

# Generar slug
SLUG=$(slugify "$TITLE")
echo -e "${YELLOW}?${NC} Slug sugerido: ${BLUE}$SLUG${NC}"
echo "  (Presiona Enter para aceptar o escribe uno nuevo):"
read -r CUSTOM_SLUG
if [ -n "$CUSTOM_SLUG" ]; then
    SLUG=$(slugify "$CUSTOM_SLUG")
fi
echo -e "${GREEN}✓${NC} Slug: $SLUG"

# Extraer o pedir descripción
if $HAS_FRONTMATTER; then
    DESCRIPTION=$(echo "$CONTENT" | grep -E "^description:" | head -1 | sed 's/description:[[:space:]]*//' | sed 's/^["'"'"']//' | sed 's/["'"'"']$//')
fi

if [ -z "$DESCRIPTION" ]; then
    echo -e "${YELLOW}?${NC} Introduce una descripción corta:"
    read -r DESCRIPTION
fi
echo -e "${GREEN}✓${NC} Descripción: ${DESCRIPTION:0:60}..."

# Extraer o pedir tags
if $HAS_FRONTMATTER; then
    TAGS=$(echo "$CONTENT" | grep -E "^tags:" | head -1 | sed 's/tags:[[:space:]]*//')
fi

if [ -z "$TAGS" ]; then
    echo -e "${YELLOW}?${NC} Introduce los tags (separados por comas, ej: ai, education, project):"
    read -r TAGS_INPUT
    # Convertir a formato array
    TAGS="[$(echo "$TAGS_INPUT" | sed 's/,\s*/", "/g' | sed 's/^/"/' | sed 's/$/"/' )]"
fi
echo -e "${GREEN}✓${NC} Tags: $TAGS"

# Fecha
YEAR=$(date +%Y)
MONTH=$(date +%m)
DAY=$(date +%d)
MONTH_NAME=$(get_month_name "$MONTH")
PUB_DATE="${YEAR}-${MONTH}-${DAY}T00:00:00Z"

echo -e "${GREEN}✓${NC} Fecha: $PUB_DATE"

# Preguntar si es draft
echo -e "${YELLOW}?${NC} ¿Es un borrador? (s/N):"
read -r IS_DRAFT
if [[ "$IS_DRAFT" =~ ^[Ss]$ ]]; then
    DRAFT="true"
else
    DRAFT="false"
fi
echo -e "${GREEN}✓${NC} Draft: $DRAFT"

echo ""
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BLUE}📁 Procesando archivos...${NC}"
echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# Crear directorios
POST_DIR="$PROJECT_DIR/src/content/blog/$YEAR"
IMAGES_DIR="$PROJECT_DIR/public/assets/img/$YEAR/$MONTH_NAME"

mkdir -p "$POST_DIR"
mkdir -p "$IMAGES_DIR"

echo -e "${GREEN}✓${NC} Directorio de posts: $POST_DIR"
echo -e "${GREEN}✓${NC} Directorio de imágenes: $IMAGES_DIR"

# Extraer el cuerpo del markdown (sin frontmatter)
if $HAS_FRONTMATTER; then
    # Remover frontmatter existente
    BODY=$(echo "$CONTENT" | sed -n '/^---$/,/^---$/!p' | tail -n +1)
    # Si el sed anterior no funcionó bien, intentar otra forma
    if [ -z "$BODY" ]; then
        BODY=$(echo "$CONTENT" | awk '/^---$/{p++} p==2{p++} p>2')
    fi
else
    BODY="$CONTENT"
fi

# Procesar imágenes
IMAGE_COUNT=0
IMAGE_PREFIX="${SLUG}_${YEAR}${MONTH}"

# Función para procesar una imagen
process_image() {
    local img_path="$1"
    local img_name=$(basename "$img_path")
    local ext="${img_name##*.}"
    
    IMAGE_COUNT=$((IMAGE_COUNT + 1))
    local new_name="${IMAGE_PREFIX}_$(printf "%02d" $IMAGE_COUNT).${ext}"
    local dest_path="$IMAGES_DIR/$new_name"
    
    cp "$img_path" "$dest_path"
    echo -e "${GREEN}✓${NC} Imagen copiada: $new_name"
    
    # Devolver la nueva ruta para el markdown
    echo "/assets/img/$YEAR/$MONTH_NAME/$new_name"
}

# Si se proporcionó carpeta de imágenes, copiarlas
if [ -n "$IMAGES_FOLDER" ] && [ -d "$IMAGES_FOLDER" ]; then
    echo ""
    echo -e "${BLUE}📷 Procesando imágenes...${NC}"
    
    # Crear array asociativo para mapear rutas originales a nuevas
    declare -A IMAGE_MAP
    
    for img in "$IMAGES_FOLDER"/*.{png,jpg,jpeg,gif,webp,PNG,JPG,JPEG,GIF,WEBP} 2>/dev/null; do
        if [ -f "$img" ]; then
            img_basename=$(basename "$img")
            new_path=$(process_image "$img")
            IMAGE_MAP["$img_basename"]="$new_path"
        fi
    done
    
    # Reemplazar rutas de imágenes en el cuerpo
    for orig_name in "${!IMAGE_MAP[@]}"; do
        new_path="${IMAGE_MAP[$orig_name]}"
        # Reemplazar varias formas posibles de referencia
        BODY=$(echo "$BODY" | sed "s|]($orig_name)|]($new_path)|g")
        BODY=$(echo "$BODY" | sed "s|](./$orig_name)|]($new_path)|g")
        BODY=$(echo "$BODY" | sed "s|](images/$orig_name)|]($new_path)|g")
        BODY=$(echo "$BODY" | sed "s|](./images/$orig_name)|]($new_path)|g")
    done
fi

# También buscar imágenes referenciadas en el markdown que estén en la misma carpeta que el archivo
INPUT_DIR=$(dirname "$INPUT_FILE")
if [ -d "$INPUT_DIR" ]; then
    # Extraer referencias de imágenes del markdown
    IMG_REFS=$(echo "$BODY" | grep -oE '!\[([^]]*)\]\(([^)]+)\)' | grep -oE '\([^)]+\)' | tr -d '()' || true)
    
    for img_ref in $IMG_REFS; do
        # Si es una ruta relativa y el archivo existe
        if [[ ! "$img_ref" =~ ^https?:// ]] && [[ ! "$img_ref" =~ ^/assets/ ]]; then
            possible_path="$INPUT_DIR/$img_ref"
            if [ -f "$possible_path" ]; then
                new_path=$(process_image "$possible_path")
                BODY=$(echo "$BODY" | sed "s|]($img_ref)|]($new_path)|g")
            fi
        fi
    done
fi

# Crear el nuevo frontmatter
FRONTMATTER="---
title: \"$TITLE\"
pubDatetime: $PUB_DATE
description: \"$DESCRIPTION\"
tags: $TAGS
draft: $DRAFT
---"

# Crear el archivo del post
POST_FILE="$POST_DIR/$SLUG.md"

echo "$FRONTMATTER" > "$POST_FILE"
echo "" >> "$POST_FILE"
echo "$BODY" >> "$POST_FILE"

echo ""
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${GREEN}✅ Post creado exitosamente!${NC}"
echo -e "${GREEN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "📄 Post: ${BLUE}$POST_FILE${NC}"
echo -e "📷 Imágenes: ${BLUE}$IMAGES_DIR${NC} ($IMAGE_COUNT archivos)"
echo ""
echo -e "${YELLOW}Próximos pasos:${NC}"
echo "  1. Revisa el post: code \"$POST_FILE\""
echo "  2. Previsualiza: npm run dev"
echo "  3. Publica: git add -A && git commit -m 'feat: add post $SLUG' && git push"
echo ""

# Abrir el archivo en VS Code
code "$POST_FILE"
