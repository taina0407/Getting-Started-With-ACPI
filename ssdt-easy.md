# SSDTs: The easy way

So here we'll be using a super simple tool made by CorpNewt: [SSDTTime](https://github.com/corpnewt/SSDTTime)

What this tool does is dumps your DSDT from your firmware, and then creates SSDTs based off your DSDT. **This must be done on the target machine running either Windows or Linux**

So what **can't** SSDTTime do?:

* **HEDT SSDTs**: 
   * The ACPI is odd on these platforms so manual work is required
* **Laptop EC fix**: 
   * This is because you need to use an ACPI rename over an SSDT on laptops
* **SSDT-PNLF**: 
   * No need to configuration required for most, use prebuilt file [here](https://github.com/khronokernel/Getting-Started-With-ACPI/blob/master/extra-files/SSDT-PNLF.aml)
* **SSDT-GPI0**: 
   * Need to be configured to your system: [SSDT-GPI0.dsl](https://github.com/khronokernel/Getting-Started-With-ACPI/blob/master/extra-files/SSDT-GPI0.dsl)
* **AWAC and RTC0 SSDTs**: 
   * 300 series intel boards will also need to figure his out(Z390 systems are most common for requiring this but some gigabyte Z370 do as well)
* **PMC SSDT**: 
   * For fixing 300 series intel NVRAM
* **USBX SSDT**: 
   * This is included on sample SSDTs but SSDTTime only makes the SSDT-EC part, Skylake and newer users can grab a prebuilt here: [SSDT-USBX.aml](https://github.com/khronokernel/Opencore-Vanilla-Desktop-Guide/blob/master/extra-files/SSDT-USBX.aml)

For users who don't have all the options avaible to them in SSDTTime, you can follow the "SSDTs: The long way" section. You can still use SSDTTime for SSDTs it support for you.

## Running SSDTTime

Run the `SSDTTime.bat` file as Admin on the target machine and you should see something like this:

![](https://cdn.discordapp.com/attachments/456913818467958789/669260286007705623/unknown.png)

What are all these options?:

* `1. FixHPET    - Patch out IRQ Conflicts`
   * IRQ patching, mainly needed for X79, X99 and laptop users
* `2. FakeEC     - OS-aware Fake EC`
   * This is the SSDT-EC, required for Catalina users
* `3. PluginType - Sets plugin-type = 1 on CPU0/PR00`
   * This is the SSDT-PLUG, for Intel only
* `4. Dump DSDT  - Automatically dump the system DSDT`
   * Dumps your DSDT from your firmware


What we want to do is select option `4. Dump DSDT` first, then select the appropriate option(s) for your system. 

> What about USBX?

For Skylake+ and AMD, you can grab a prebuilt file here: [SSDT-USBX.aml](https://github.com/khronokernel/Opencore-Vanilla-Desktop-Guide/blob/master/extra-files/SSDT-USBX.aml). This file is plug and play and requires no device configuration, **do not use on Broadwell and older**.

**Troubleshooting note**: See [General Troubleshooting](https://khronokernel.github.io/Opencore-Vanilla-Desktop-Guide/troubleshooting/troubleshooting.html) if you're having issues running SSDTTime

## Adding to OpenCore

Don't forget that SSDTs need to be added to Opencore, eminder that .aml is complied, .dsl is code. **Add only the .aml file**:
* EFI/OC/ACPI
* config.plist -> ACPI -> Add

Reminder that Cmd/Crtl+R with ProperTree pointed at your OC folder will add all your SSDTs, kexts and .efi drivers to the config for you. **Do not add your DSDT to OpenCore, its already in your firmware**

Users of `FixHPET` will also need to merge oc_patches.plist into their config.plist

Steps to do this:

* Open both files, 
* Delete the `ACPI -> Patch` section from config.plist
* Copy the `ACPI -> Patch` section from patches.plist
* Paste into where old patches were in config.plist
