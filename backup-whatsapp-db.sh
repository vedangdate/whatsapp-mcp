#!/bin/bash
# Backup WhatsApp MCP SQLite databases to OneDrive
# Uses sqlite3 .backup for safe copying (handles locks)

SOURCE_DIR="/Users/vedangdp/projects/whatsapp-mcp/whatsapp-bridge/store"
BACKUP_DIR="/Users/vedangdp/Library/CloudStorage/OneDrive-Personal/Backups/whatsapp-mcp"
DATE=$(date +%Y-%m-%d)

# Backup messages.db
sqlite3 "$SOURCE_DIR/messages.db" ".backup '$BACKUP_DIR/messages-$DATE.db'"

# Backup whatsapp.db (session/auth)
sqlite3 "$SOURCE_DIR/whatsapp.db" ".backup '$BACKUP_DIR/whatsapp-$DATE.db'"

# Also keep a "latest" copy for easy access
sqlite3 "$SOURCE_DIR/messages.db" ".backup '$BACKUP_DIR/messages-latest.db'"
sqlite3 "$SOURCE_DIR/whatsapp.db" ".backup '$BACKUP_DIR/whatsapp-latest.db'"

# Clean up backups older than 30 days
find "$BACKUP_DIR" -name "*.db" -not -name "*latest*" -mtime +30 -delete

echo "$(date): WhatsApp DB backed up to $BACKUP_DIR"
