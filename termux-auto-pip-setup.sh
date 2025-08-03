#!/data/data/com.termux/files/usr/bin/bash
set -e

LOGFILE="$HOME/termux-setup.log"
ENV_DIR="$HOME/freqtrade-env"

echo "[*] Logging to $LOGFILE"
echo "====== Termux Python Setup: $(date) ======" > "$LOGFILE"

echo "[*] Updating packages..." | tee -a "$LOGFILE"
pkg update -y && pkg upgrade -y >> "$LOGFILE" 2>&1

echo "[*] Installing Python and essentials..." | tee -a "$LOGFILE"
pkg install -y python clang git openssl libffi libcrypt build-essential >> "$LOGFILE" 2>&1

echo "[*] Upgrading pip, setuptools, wheel..." | tee -a "$LOGFILE"
pip install --upgrade pip setuptools wheel >> "$LOGFILE" 2>&1

echo "[*] Installing virtualenv..." | tee -a "$LOGFILE"
pip install virtualenv >> "$LOGFILE" 2>&1

echo "[*] Creating virtualenv at $ENV_DIR..." | tee -a "$LOGFILE"
python -m virtualenv "$ENV_DIR" >> "$LOGFILE" 2>&1

echo "[*] Activating virtualenv..." | tee -a "$LOGFILE"
source "$ENV_DIR/bin/activate"

echo "[*] Writing requirements-termux.txt..." | tee -a "$LOGFILE"
cat << EOT > requirements-termux.txt
numpy==2.3.2
pandas==2.3.1
filelock==3.18.0
distlib==0.4.0
platformdirs==4.3.8
python-dateutil==2.9.0.post0
pytz==2025.2
setuptools==80.9.0
six==1.17.0
tzdata==2025.2
virtualenv==20.32.0
wheel==0.45.1
EOT

echo "[*] Installing Python packages..." | tee -a "$LOGFILE"
pip install -r requirements-termux.txt >> "$LOGFILE" 2>&1

echo "[✓] Done! Python environment is ready." | tee -a "$LOGFILE"
echo "[✓] Virtualenv: $ENV_DIR"
echo "[✓] To activate: source $ENV_DIR/bin/activate"
