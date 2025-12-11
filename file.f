

-64
-uvmhome /home/cc/mnt/XCELIUM2309/tools/methodology/UVM/CDNS-1.1d
-sv
-uvm
-timescale 1ns/1ns

// Include directories

-incdir /home/cc/Talha/UVM_Project/exercise/task/shapatar/UVM_based_verification_of_AES_Rijndael_core/UVM/sv
-incdir /home/cc/Talha/UVM_Project/VerificationProjects(1)/VerificationProjects/VerifProj4_AES_by_Rijndael/ENCRYPTION_UNIT_V1/CIPHER_UNIT/sv

// Compile UVC package & interface files

// YAPP UVC
../sv/aes_pkg.sv
../sv/aes_interface.sv


	  

	
/home/cc/Talha/UVM_Project/VerificationProjects(1)/VerificationProjects/VerifProj4_AES_by_Rijndael/ENCRYPTION_UNIT_V1/CIPHER_UNIT/sv/S_Box.sv
/home/cc/Talha/UVM_Project/VerificationProjects(1)/VerificationProjects/VerifProj4_AES_by_Rijndael/ENCRYPTION_UNIT_V1/CIPHER_UNIT/sv/Inv_S_Box.sv
/home/cc/Talha/UVM_Project/VerificationProjects(1)/VerificationProjects/VerifProj4_AES_by_Rijndael/ENCRYPTION_UNIT_V1/CIPHER_UNIT/sv/Xtime.sv

/home/cc/Talha/UVM_Project/VerificationProjects(1)/VerificationProjects/VerifProj4_AES_by_Rijndael/ENCRYPTION_UNIT_V1/CIPHER_UNIT/sv/GFunc.sv
/home/cc/Talha/UVM_Project/VerificationProjects(1)/VerificationProjects/VerifProj4_AES_by_Rijndael/ENCRYPTION_UNIT_V1/CIPHER_UNIT/sv/HFunc.sv

/home/cc/Talha/UVM_Project/VerificationProjects(1)/VerificationProjects/VerifProj4_AES_by_Rijndael/ENCRYPTION_UNIT_V1/CIPHER_UNIT/sv/MixColumn.sv
/home/cc/Talha/UVM_Project/VerificationProjects(1)/VerificationProjects/VerifProj4_AES_by_Rijndael/ENCRYPTION_UNIT_V1/CIPHER_UNIT/sv/ARK.sv
/home/cc/Talha/UVM_Project/VerificationProjects(1)/VerificationProjects/VerifProj4_AES_by_Rijndael/ENCRYPTION_UNIT_V1/CIPHER_UNIT/sv/BS.sv
/home/cc/Talha/UVM_Project/VerificationProjects(1)/VerificationProjects/VerifProj4_AES_by_Rijndael/ENCRYPTION_UNIT_V1/CIPHER_UNIT/sv/MC.sv
/home/cc/Talha/UVM_Project/VerificationProjects(1)/VerificationProjects/VerifProj4_AES_by_Rijndael/ENCRYPTION_UNIT_V1/CIPHER_UNIT/sv/KEXP.sv
/home/cc/Talha/UVM_Project/VerificationProjects(1)/VerificationProjects/VerifProj4_AES_by_Rijndael/ENCRYPTION_UNIT_V1/CIPHER_UNIT/sv/ByteSub.sv
/home/cc/Talha/UVM_Project/VerificationProjects(1)/VerificationProjects/VerifProj4_AES_by_Rijndael/ENCRYPTION_UNIT_V1/CIPHER_UNIT/sv/State.sv
/home/cc/Talha/UVM_Project/VerificationProjects(1)/VerificationProjects/VerifProj4_AES_by_Rijndael/ENCRYPTION_UNIT_V1/CIPHER_UNIT/sv/Register.sv
/home/cc/Talha/UVM_Project/VerificationProjects(1)/VerificationProjects/VerifProj4_AES_by_Rijndael/ENCRYPTION_UNIT_V1/CIPHER_UNIT/sv/dem1_8.sv
/home/cc/Talha/UVM_Project/VerificationProjects(1)/VerificationProjects/VerifProj4_AES_by_Rijndael/ENCRYPTION_UNIT_V1/CIPHER_UNIT/sv/dem1_9.sv
/home/cc/Talha/UVM_Project/VerificationProjects(1)/VerificationProjects/VerifProj4_AES_by_Rijndael/ENCRYPTION_UNIT_V1/CIPHER_UNIT/sv/dem1_11.sv
/home/cc/Talha/UVM_Project/VerificationProjects(1)/VerificationProjects/VerifProj4_AES_by_Rijndael/ENCRYPTION_UNIT_V1/CIPHER_UNIT/sv/demux1_11.sv
/home/cc/Talha/UVM_Project/VerificationProjects(1)/VerificationProjects/VerifProj4_AES_by_Rijndael/ENCRYPTION_UNIT_V1/CIPHER_UNIT/sv/mux3_1.sv
/home/cc/Talha/UVM_Project/VerificationProjects(1)/VerificationProjects/VerifProj4_AES_by_Rijndael/ENCRYPTION_UNIT_V1/CIPHER_UNIT/sv/mux15_1.sv
/home/cc/Talha/UVM_Project/VerificationProjects(1)/VerificationProjects/VerifProj4_AES_by_Rijndael/ENCRYPTION_UNIT_V1/CIPHER_UNIT/sv/RS.sv
/home/cc/Talha/UVM_Project/VerificationProjects(1)/VerificationProjects/VerifProj4_AES_by_Rijndael/ENCRYPTION_UNIT_V1/CIPHER_UNIT/sv/CU_S.sv
/home/cc/Talha/UVM_Project/VerificationProjects(1)/VerificationProjects/VerifProj4_AES_by_Rijndael/ENCRYPTION_UNIT_V1/CIPHER_UNIT/sv/aes.sv


aes_hw_top.sv
aes_top.sv

// Simulation options
+UVM_TESTNAME=simple_test
+UVM_VERBOSITY=UVM_FULL
//+SVSEED=random

//-gui -access +rwc




















