const fs = require('fs');
const path = require('path');

const delay = ms => new Promise(resolve => setTimeout(resolve, ms));

module.exports = {
  trigger: 'autorespon',
  execute: async (sock, m, args, { isOwner }) => {
    if (!isOwner) {
      return sock.sendMessage(
        m.key.remoteJid,
        { text: '❌ Hanya owner yang bisa mengatur autorespon.' },
        { quoted: m }
      );
    }

    const remoteJid = m.key.remoteJid;
    const arPath = path.join(__dirname, '..', 'autoresponder.json');
    let data = {};

    try {
      if (fs.existsSync(arPath)) {
        data = JSON.parse(fs.readFileSync(arPath, 'utf-8'));
      }
    } catch (err) {
      console.error('Gagal membaca autoresponder.json:', err);
    }

    if (!args.length) {
      const status = data.text
        ? `✅ Autorespon aktif:\n\n${data.text}`
        : '❌ Autorespon belum diatur.\n\nGunakan: .autorespon <teks>';

      return sock.sendMessage(
        remoteJid,
        { text: status },
        { quoted: m }
      );
    }

    const text = args.join(' ');
    data.text = text;

    fs.writeFileSync(arPath, JSON.stringify(data, null, 2));

    await delay(10000);

    await sock.sendMessage(
      remoteJid,
      {
        text: `✅ Autorespon berhasil diatur:\n\n${text}`
      },
      {
        quoted: m
      }
    );
  }
};
