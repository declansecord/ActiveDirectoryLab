<h1>Active Directory Lab with Windows Server 2019</h1>

<h2>Description</h2>
<p>In today's interconnected world, mastering the intricacies of network administration and domain management is not just a valuable skill—it's a critical one. The ability to seamlessly integrate multiple systems, manage vast numbers of users, and ensure data security is at the core of modern IT infrastructure. To sharpen my understanding and gain hands-on experience, I embarked on a mission to create a home lab environment. This project was centred around setting up an Active Directory (AD) domain within a virtualised environment.

Active Directory, a directory service developed by Microsoft, plays a pivotal role in network administration, providing a centralised location for network object management and ensuring the availability of network resources to users and computers. The home lab setup detailed in this write-up simulates a real-world scenario, one where a single domain controller manages a significant number of user accounts and interfaces with a client machine.

<b><i>The script and names.txt file used in this lab are available within this repository</b></i>
</p>

<h2>Objectives</h2>
<p>
The primary aim of this home lab project was to delve deep into the practicalities of network and user management within a Windows-centric environment. By building this setup from scratch, I sought to achieve the following objectives:

- <b>Domain Controller Setup:</b> Establish a robust domain controller using Windows Server 2019, the heart of our network management system. The domain controller would serve as the primary authority to manage users, resources, and security policies.

- <b>Dual-NIC Configuration:</b> Implement a dual network interface card (NIC) setup on the domain controller. By segregating internet-facing and internal traffic, this configuration aims to provide enhanced security and separation of concerns—a critical aspect in real-world network environments.

- <b>Dynamic Host Configuration Protocol (DHCP) Implementation:</b> Install and configure DHCP on the server to dynamically allocate IP addresses from a pre-defined pool. This automates the IP management process, ensuring smooth network operations and reducing IP conflicts.

- <b>User Management:</b> Create a substantial user base by adding 1000 users to the domain. This would not only test the system's scalability but also mimic a real-world scenario where a domain controller manages multiple user accounts.

- <b>Client Machine Integration:</b> Integrate a Windows 10 Pro virtual machine (VM) into the domain. This VM would serve as a typical client endpoint, providing a practical perspective on how users interact with domain resources. Furthermore, I aimed to configure the VM to allow any of the 1000 users to log in, showcasing the versatility and flexibility of AD's user management.

- <b>Documentation and Learning:</b> Capture the entire process meticulously, creating a valuable resource for others interested in this domain. Furthermore, each step was an opportunity for me to refine my understanding, troubleshoot issues, and deepen my expertise.
</p>

<h2>Technologies Utilised</h2>
<p>
  
- <b><a href="https://www.virtualbox.org/" target="_blank">Oracle VM VirtualBox</a></b>
 was employed to create and manage virtual machines. This allowed for a controlled environment where the server and client VMs could interact without external interferences.

- <b><a href="https://www.microsoft.com/en-us/evalcenter/download-windows-server-2019">Windows Server 2019</b> was used as the backbone of the domain environment; its features, particularly in relation to Active Directory Domain Services (AD DS), made it a great choice as the domain controller.

- <b><a href="https://www.microsoft.com/en-gb/software-download/windows10">Windows 10 Pro</b> was used as the client end device used to connect to the domain

- <b><a href="https://learn.microsoft.com/en-us/powershell/scripting/overview?view=powershell-7.3">PowerShell</b> was used to automate the creation of users from a list of full names

</p>

<h2>Configuration of Environment</h2>

<h3>Initialising the Virtual Machines</h3>
<p>
  
<b>Windows Server 2019</b>
- 4 CPU Cores
- 8192MB RAM
- 50GB Virtual Hard Disk
- 2 Network Adapters, one set to NAT and the other set to Internal Network

  <br>
  <img src="https://i.imgur.com/1nQRUNU.png" alt="Configuration settings for the Windows Server 2019 virtual machine">

<b>Windows 10 Pro</b>
- 4 CPU Cores
- 8192MB RAM
- 50GB Virtual Hard Disk
- 1 Network Adapter, set to Internal Network

<br>
<img src="https://i.imgur.com/QgVnl83.png" alt="Configuration settings for the Windows 10 Pro virtual machine">

</p>

<h3>Windows Server 2019 Configuration</h3>
<p>
A fresh installation of Windows Server 2019 was performed using the ISO file acquired from Microsoft. The default settings were used, with custom configurations being set in the following steps.

Using the Server Manager tool, the Active Directory Domain Services role was installed, and subsequently, the server was promoted to a domain controller for a new domain called 'homelab.com'.

<br>
<img src="https://i.imgur.com/KvKAw0p.png" alt="Setting up 'homelab.com' as the domain in Server Manager">

The NAT Network Adapter was given dynamic IP settings, allowing it to obtain IP addresses automatically when connecting to external networks. 

The Internal Network Adapter was configured with a static IP address, 172.16.0.1, and would serve as the default gateway to any devices joining the domain.

<br>
<img src="https://i.imgur.com/106E1HI.png" alt="The configuration of each network adapter">

</p>

<h3>DHCP Configuration</h3>
<p>
Using the Server Manager, the DHCP role was added to my server. 
  
A new DHCP scope define, specifying the range of IP addresses to be allocated to devices within the domain's internal network

The IP range selected was 172.16.0.100 - 172.16.0.200.

No reservations nor exclusions were configured.

<br>
<img src="https://i.imgur.com/L3XZm9S.png" alt="The DHCP scope configuration settings">
</p>

<h3>User Management</h3>
<p>
Using PowerShell, I wrote a script to iterate through 1000 first name and last name combinations, forming usernames from a combination of the two.

These usernames were used to batch-create domain user accounts, the script is shown below.

<br>
<img src="https://i.imgur.com/mkBTYru.png" alt="PowerShell script used to batch create users">

Since this is a test environment, the same password was applied to all user accounts, however in a real environment, a complex, 12+ character password would be computed per user account to ensure high levels of security. The users may be prompted to change their password when they first attempt to log in, and the password they choose will expire after a predefined amount of time has elapsed.

<br>
<img src=https://i.imgur.com/s3NfAXE.png alt="Batch-created user accounts in Active Directory.">

</p>

<h3>Windows 10 Pro Configuration</h3>
<p>
A fresh installation of Windows 10 Pro was performed using the Windows 10 ISO file acquired from the Microsoft media creation tool.

Using the System Properties settings, the virtual machine was added into the domain (homelab.com) allowing any of the 1000 created users to log into this machine.

<br>
<img src="https://i.imgur.com/nps4eXO.png" alt="Windows 10 Pro VM joined to 'homelab.com' domain.">
<img src="https://i.imgur.com/ue24MBA.png" alt="Windows login screen showing the connected domain."
</p>

<h2>Conclusion</h2>
<p>
Setting up this home lab environment proved to be both an informative and practical exercise. The project offered firsthand experience with several key components:

- <b>Active Directory:</b> Establishing and managing a domain with 1000 users underscored the capabilities and utilities of AD in a network environment.

- <b>Network Management:</b> The dual NIC setup illustrated the importance of differentiating internal and external communications, a practice often critical in larger setups.

- <b>Automation:</b> Using PowerShell for batch tasks emphasised its utility in simplifying and speeding up repetitive tasks.

- <b>Client Integration:</b> Joining a Windows 10 VM to the domain gave a practical understanding of endpoint management and user access in a networked environment.

While there were challenges along the way, each provided its own learning opportunity. The project reinforced the notion that hands-on practice, even in a controlled setting, is invaluable for gaining a solid grasp of IT concepts.

Overall, this endeavor was an essential step in my journey to better understand domain and network management, and I look forward to building upon this foundation in future projects.
</p>
