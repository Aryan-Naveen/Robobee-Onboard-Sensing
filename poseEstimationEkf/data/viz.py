import matplotlib.pyplot as plt
import numpy as np

output = []

file = open('data.txt', 'r')
data = file.read().splitlines()[5:]
dt = 20
t = np.arange(0, dt*len(data), dt)
for d in data:
    output.append([float(val) for val in d.split(' ')])

output = np.array(output)
fig, axs = plt.subplots(2, 1)
axs[0].plot(t, output[:, 0], color='r', alpha = 0.3, label=r'$\omega_x$')
axs[0].plot(t, output[:, 1], color ='r', alpha = 0.3, label=r'$\omega_y$')
axs[0].plot(t, output[:, 2], color = 'r', alpha=0.3, label=r'$\omega_z$')
axs[0].plot(t, output[:, 3], color='orange', alpha = 0.3, label=r'$a_x$')
axs[0].plot(t, output[:, 4], color ='orange', alpha = 0.3, label=r'$a_y$')
axs[0].plot(t, output[:, 5], color = 'orange', alpha=0.3, label=r'$a_z$')
axs[0].plot(t, output[:, 6], color='black', alpha = 1, label=r'$\theta_x$')
axs[0].plot(t, output[:, 7], color ='black', alpha = 1, label=r'$\theta_y$')
axs[0].plot(t, output[:, 8], color = 'black', alpha=1, label=r'$\theta_z$')
axs[0].set_xlabel('Milliseconds')
axs[0].legend()
axs[1].plot(t, [abs(val) for val in output[:, 9]], label=r'estimated height')
print(np.mean([output[:, 9]]))
print(np.std([output[:, 9]]))
axs[1].plot(t, [117 for val in output[:, 9]], alpha=0.5, label=r'true height')
axs[1].set_ylim([50, 200])
axs[1].legend()
plt.show()
file.close()
