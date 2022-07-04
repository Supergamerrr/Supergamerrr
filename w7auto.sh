echo "Автоматическое начало..."
echo "Сейчас используется данное IP"
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
sleep 1
echo "Запуск через 9 секунд."
sleep 9
qemu-system-x86_64 -hda w7x64.img -m $RAM$RAM2 -smp cores=$CORES,threads=$THREADS -net user,hostfwd=tcp::3388-:3389 -net nic -object rng-random,id=rng0,filename=/dev/urandom -device virtio-rng-pci,rng=rng0 -vga vmware -nographic
