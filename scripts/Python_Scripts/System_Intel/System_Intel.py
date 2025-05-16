import platform
import psutil
import socket
import uuid
import os
import speedtest as speedtest_cli

# Try importing GPUtil (optional dependency)
try:
    import GPUtil
    GPUtil_AVAILABLE = True
except ImportError:
    GPUtil_AVAILABLE = False

def get_size(bytes, suffix="B"):
    factor = 1024
    for unit in ["", "K", "M", "G", "T"]:
        if bytes < factor:
            return f"{bytes:.2f}{unit}{suffix}"
        bytes /= factor

def cpu_info():
    print("[🧠] CPU INFO")
    print("Processor:", platform.processor() or "Unavailable")
    print("Cores (Physical):", psutil.cpu_count(logical=False))
    print("Cores (Logical):", psutil.cpu_count(logical=True))
    print("CPU Usage:", psutil.cpu_percent(interval=1), "%")
    print()

def gpu_info():
    print("[🎮] GPU INFO")
    if not GPUtil_AVAILABLE:
        print("GPUtil module not found. GPU info unavailable.")
        print("Install it with: pip install gputil")
        return
    try:
        gpus = GPUtil.getGPUs()
        if not gpus:
            print("No GPU found.")
        for gpu in gpus:
            print(f"Name: {gpu.name}")
            print(f"Load: {gpu.load * 100:.1f}%")
            print(f"Memory Free: {get_size(gpu.memoryFree * 1024**2)}")
            print(f"Memory Used: {get_size(gpu.memoryUsed * 1024**2)}")
            print(f"Memory Total: {get_size(gpu.memoryTotal * 1024**2)}")
            print()
    except Exception as e:
        print("GPU check failed:", e)
        print()

def ram_info():
    print("[💾] RAM INFO")
    svmem = psutil.virtual_memory()
    print("Total:", get_size(svmem.total))
    print("Available:", get_size(svmem.available))
    print("Used:", get_size(svmem.used))
    print("Percentage:", svmem.percent, "%")
    print()

def disk_info():
    print("[📀] DISK INFO")
    partitions = psutil.disk_partitions()
    for p in partitions:
        try:
            usage = psutil.disk_usage(p.mountpoint)
            print(f"Device: {p.device}")
            print(f"Mountpoint: {p.mountpoint}")
            print(f"File system type: {p.fstype}")
            print(f"Total Size: {get_size(usage.total)}")
            print(f"Used: {get_size(usage.used)}")
            print(f"Free: {get_size(usage.free)}")
            print(f"Percentage: {usage.percent}%")
            print()
        except PermissionError:
            continue

def motherboard_info():
    print("[🧬] MOTHERBOARD INFO")
    try:
        if platform.system() == "Windows":
            os.system("wmic baseboard get product,Manufacturer,version,serialnumber")
        elif platform.system() == "Linux":
            os.system("sudo dmidecode -t baseboard | grep -A3 'Base Board'")
        elif platform.system() == "Darwin":
            print("Use 'system_profiler SPHardwareDataType' manually on macOS.")
        else:
            print("Unsupported OS for motherboard details.")
    except Exception as e:
        print("Error fetching motherboard info:", e)
    print()

def network_info():
    print("[🌐] NETWORK INFO")
    hostname = socket.gethostname()
    try:
        ip = socket.gethostbyname(hostname)
    except socket.gaierror:
        ip = "Unavailable"

    print("Hostname:", hostname)
    print("Local IP:", ip)

    try:
        socket.create_connection(("www.google.com", 80), timeout=5)
        print("Internet: Connected")
    except:
        print("Internet: Disconnected")

    try:
        st = speedtest_cli.Speedtest()
        print("Download Speed:", f"{st.download() / 1024 / 1024:.2f} Mbps")
        print("Upload Speed:", f"{st.upload() / 1024 / 1024:.2f} Mbps")
    except Exception as e:
        print("Speedtest Failed:", e)
    print()

def system_info():
    print("[💻] SYSTEM INFO")
    print("System:", platform.system())
    print("Node Name:", platform.node())
    print("Release:", platform.release())
    print("Version:", platform.version())
    print("Machine:", platform.machine())
    print("Processor:", platform.processor() or "Unavailable")
    print()

if __name__ == "__main__":
    system_info()
    cpu_info()
    gpu_info()
    ram_info()
    disk_info()
    motherboard_info()
    network_info()
