// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT license.

#include "../src/troy_cuda.cuh"
#include <cstddef>
#include <cstdint>
#include <ctime>
#include "gtest/gtest.h"

// using namespace troy;
using namespace std;

using troy::ParmsID;
using troy::SchemeType;
using troy::SecurityLevel;
using troy::Modulus;
using troy::CoeffModulus;
using EncryptionParameters = troy::EncryptionParametersCuda;
using SEALContext = troy::SEALContextCuda;
using Plaintext = troy::PlaintextCuda;
using Ciphertext = troy::CiphertextCuda;
using Encryptor = troy::EncryptorCuda;
using Decryptor = troy::DecryptorCuda;
using Evaluator = troy::EvaluatorCuda;

/*

namespace troytest
{
    TEST(EncryptorTest, BFVEncryptDecrypt)
    {
        EncryptionParameters parms(SchemeType::bfv);
        Modulus plain_modulus(1 << 6);
        parms.setPlainModulus(plain_modulus);
        {
            parms.setPolyModulusDegree(64);
            parms.setCoeffModulus(CoeffModulus::Create(64, { 40 }));
            SEALContext context(parms, false, SecurityLevel::none);
            KeyGenerator keygen(context);
            PublicKey pk;
            keygen.createPublicKey(pk);

            Encryptor encryptor(context, pk);
            Decryptor decryptor(context, keygen.secretKey());

            Ciphertext encrypted;
            Plaintext plain;
            string hex_poly;

            hex_poly =
                "1x^28 + 1x^25 + 1x^21 + 1x^20 + 1x^18 + 1x^14 + 1x^12 + 1x^10 + 1x^9 + 1x^6 + 1x^5 + 1x^4 + 1x^3";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly = "0";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly = "1";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly = "1x^1";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly =
                "1x^62 + 1x^61 + 1x^60 + 1x^59 + 1x^58 + 1x^57 + 1x^56 + 1x^55 + 1x^54 + 1x^53 + 1x^52 + 1x^51 + 1x^50 "
                "+ 1x^49 + 1x^48 + 1x^47 + 1x^46 + 1x^45 + 1x^44 + 1x^43 + 1x^42 + 1x^41 + 1x^40 + 1x^39 + 1x^38 + "
                "1x^37 + 1x^36 + 1x^35 + 1x^34 + 1x^33 + 1x^32 + 1x^31 + 1x^30 + 1x^29 + 1x^28 + 1x^27 + 1x^26 + 1x^25 "
                "+ 1x^24 + 1x^23 + 1x^22 + 1x^21 + 1x^20 + 1x^19 + 1x^18 + 1x^17 + 1x^16 + 1x^15 + 1x^14 + 1x^13 + "
                "1x^12 + 1x^11 + 1x^10 + 1x^9 + 1x^8 + 1x^7 + 1x^6 + 1x^5 + 1x^4 + 1x^3 + 1x^2 + 1";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly =
                "1x^62 + 1x^61 + 1x^60 + 1x^59 + 1x^58 + 1x^57 + 1x^56 + 1x^55 + 1x^54 + 1x^53 + 1x^52 + 1x^51 + 1x^50 "
                "+ 1x^49 + 1x^48 + 1x^47 + 1x^46 + 1x^45 + 1x^44 + 1x^43 + 1x^42 + 1x^41 + 1x^40 + 1x^39 + 1x^38 + "
                "1x^37 + 1x^36 + 1x^35 + 1x^34 + 1x^33 + 1x^32 + 1x^31 + 1x^30 + 1x^29 + 1x^28 + 1x^27 + 1x^26 + 1x^25 "
                "+ 1x^24 + 1x^23 + 1x^22 + 1x^21 + 1x^20 + 1x^19 + 1x^18 + 1x^17 + 1x^16 + 1x^15 + 1x^14 + 1x^13 + "
                "1x^12 + 1x^11 + 1x^10 + 1x^9 + 1x^8 + 1x^7 + 1x^6 + 1x^5 + 1x^4 + 1x^3 + 1x^2 + 1x^1";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly =
                "1x^62 + 1x^61 + 1x^60 + 1x^59 + 1x^58 + 1x^57 + 1x^56 + 1x^55 + 1x^54 + 1x^53 + 1x^52 + 1x^51 + 1x^50 "
                "+ 1x^49 + 1x^48 + 1x^47 + 1x^46 + 1x^45 + 1x^44 + 1x^43 + 1x^42 + 1x^41 + 1x^40 + 1x^39 + 1x^38 + "
                "1x^37 + 1x^36 + 1x^35 + 1x^34 + 1x^33 + 1x^32 + 1x^31 + 1x^30 + 1x^29 + 1x^28 + 1x^27 + 1x^26 + 1x^25 "
                "+ 1x^24 + 1x^23 + 1x^22 + 1x^21 + 1x^20 + 1x^19 + 1x^18 + 1x^17 + 1x^16 + 1x^15 + 1x^14 + 1x^13 + "
                "1x^12 + 1x^11 + 1x^10 + 1x^9 + 1x^8 + 1x^7 + 1x^6 + 1x^5 + 1x^4 + 1x^3 + 1x^2 + 1x^1 + 1";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly =
                "1x^28 + 1x^25 + 1x^23 + 1x^21 + 1x^20 + 1x^19 + 1x^16 + 1x^15 + 1x^13 + 1x^12 + 1x^7 + 1x^5 + 1";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());
        }
        {
            parms.setPolyModulusDegree(128);
            parms.setCoeffModulus(CoeffModulus::Create(128, { 40, 40 }));
            SEALContext context(parms, false, SecurityLevel::none);
            KeyGenerator keygen(context);
            PublicKey pk;
            keygen.createPublicKey(pk);

            Encryptor encryptor(context, pk);
            Decryptor decryptor(context, keygen.secretKey());

            Ciphertext encrypted;
            Plaintext plain;
            string hex_poly;

            hex_poly =
                "1x^28 + 1x^25 + 1x^21 + 1x^20 + 1x^18 + 1x^14 + 1x^12 + 1x^10 + 1x^9 + 1x^6 + 1x^5 + 1x^4 + 1x^3";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly = "0";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly = "1";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly = "1x^1";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly =
                "1x^62 + 1x^61 + 1x^60 + 1x^59 + 1x^58 + 1x^57 + 1x^56 + 1x^55 + 1x^54 + 1x^53 + 1x^52 + 1x^51 + 1x^50 "
                "+ 1x^49 + 1x^48 + 1x^47 + 1x^46 + 1x^45 + 1x^44 + 1x^43 + 1x^42 + 1x^41 + 1x^40 + 1x^39 + 1x^38 + "
                "1x^37 + 1x^36 + 1x^35 + 1x^34 + 1x^33 + 1x^32 + 1x^31 + 1x^30 + 1x^29 + 1x^28 + 1x^27 + 1x^26 + 1x^25 "
                "+ 1x^24 + 1x^23 + 1x^22 + 1x^21 + 1x^20 + 1x^19 + 1x^18 + 1x^17 + 1x^16 + 1x^15 + 1x^14 + 1x^13 + "
                "1x^12 + 1x^11 + 1x^10 + 1x^9 + 1x^8 + 1x^7 + 1x^6 + 1x^5 + 1x^4 + 1x^3 + 1x^2 + 1";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly =
                "1x^62 + 1x^61 + 1x^60 + 1x^59 + 1x^58 + 1x^57 + 1x^56 + 1x^55 + 1x^54 + 1x^53 + 1x^52 + 1x^51 + 1x^50 "
                "+ 1x^49 + 1x^48 + 1x^47 + 1x^46 + 1x^45 + 1x^44 + 1x^43 + 1x^42 + 1x^41 + 1x^40 + 1x^39 + 1x^38 + "
                "1x^37 + 1x^36 + 1x^35 + 1x^34 + 1x^33 + 1x^32 + 1x^31 + 1x^30 + 1x^29 + 1x^28 + 1x^27 + 1x^26 + 1x^25 "
                "+ 1x^24 + 1x^23 + 1x^22 + 1x^21 + 1x^20 + 1x^19 + 1x^18 + 1x^17 + 1x^16 + 1x^15 + 1x^14 + 1x^13 + "
                "1x^12 + 1x^11 + 1x^10 + 1x^9 + 1x^8 + 1x^7 + 1x^6 + 1x^5 + 1x^4 + 1x^3 + 1x^2 + 1x^1";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly =
                "1x^62 + 1x^61 + 1x^60 + 1x^59 + 1x^58 + 1x^57 + 1x^56 + 1x^55 + 1x^54 + 1x^53 + 1x^52 + 1x^51 + 1x^50 "
                "+ 1x^49 + 1x^48 + 1x^47 + 1x^46 + 1x^45 + 1x^44 + 1x^43 + 1x^42 + 1x^41 + 1x^40 + 1x^39 + 1x^38 + "
                "1x^37 + 1x^36 + 1x^35 + 1x^34 + 1x^33 + 1x^32 + 1x^31 + 1x^30 + 1x^29 + 1x^28 + 1x^27 + 1x^26 + 1x^25 "
                "+ 1x^24 + 1x^23 + 1x^22 + 1x^21 + 1x^20 + 1x^19 + 1x^18 + 1x^17 + 1x^16 + 1x^15 + 1x^14 + 1x^13 + "
                "1x^12 + 1x^11 + 1x^10 + 1x^9 + 1x^8 + 1x^7 + 1x^6 + 1x^5 + 1x^4 + 1x^3 + 1x^2 + 1x^1 + 1";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly =
                "1x^28 + 1x^25 + 1x^23 + 1x^21 + 1x^20 + 1x^19 + 1x^16 + 1x^15 + 1x^13 + 1x^12 + 1x^7 + 1x^5 + 1";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());
        }
        {
            parms.setPolyModulusDegree(256);
            parms.setCoeffModulus(CoeffModulus::Create(256, { 40, 40, 40 }));

            SEALContext context(parms, false, SecurityLevel::none);
            KeyGenerator keygen(context);
            PublicKey pk;
            keygen.createPublicKey(pk);

            Encryptor encryptor(context, pk);
            Decryptor decryptor(context, keygen.secretKey());

            Ciphertext encrypted;
            Plaintext plain;
            string hex_poly;

            hex_poly =
                "1x^28 + 1x^25 + 1x^21 + 1x^20 + 1x^18 + 1x^14 + 1x^12 + 1x^10 + 1x^9 + 1x^6 + 1x^5 + 1x^4 + 1x^3";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly = "0";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly = "1";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly = "1x^1";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly =
                "1x^62 + 1x^61 + 1x^60 + 1x^59 + 1x^58 + 1x^57 + 1x^56 + 1x^55 + 1x^54 + 1x^53 + 1x^52 + 1x^51 + 1x^50 "
                "+ 1x^49 + 1x^48 + 1x^47 + 1x^46 + 1x^45 + 1x^44 + 1x^43 + 1x^42 + 1x^41 + 1x^40 + 1x^39 + 1x^38 + "
                "1x^37 + 1x^36 + 1x^35 + 1x^34 + 1x^33 + 1x^32 + 1x^31 + 1x^30 + 1x^29 + 1x^28 + 1x^27 + 1x^26 + 1x^25 "
                "+ 1x^24 + 1x^23 + 1x^22 + 1x^21 + 1x^20 + 1x^19 + 1x^18 + 1x^17 + 1x^16 + 1x^15 + 1x^14 + 1x^13 + "
                "1x^12 + 1x^11 + 1x^10 + 1x^9 + 1x^8 + 1x^7 + 1x^6 + 1x^5 + 1x^4 + 1x^3 + 1x^2 + 1";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly =
                "1x^62 + 1x^61 + 1x^60 + 1x^59 + 1x^58 + 1x^57 + 1x^56 + 1x^55 + 1x^54 + 1x^53 + 1x^52 + 1x^51 + 1x^50 "
                "+ 1x^49 + 1x^48 + 1x^47 + 1x^46 + 1x^45 + 1x^44 + 1x^43 + 1x^42 + 1x^41 + 1x^40 + 1x^39 + 1x^38 + "
                "1x^37 + 1x^36 + 1x^35 + 1x^34 + 1x^33 + 1x^32 + 1x^31 + 1x^30 + 1x^29 + 1x^28 + 1x^27 + 1x^26 + 1x^25 "
                "+ 1x^24 + 1x^23 + 1x^22 + 1x^21 + 1x^20 + 1x^19 + 1x^18 + 1x^17 + 1x^16 + 1x^15 + 1x^14 + 1x^13 + "
                "1x^12 + 1x^11 + 1x^10 + 1x^9 + 1x^8 + 1x^7 + 1x^6 + 1x^5 + 1x^4 + 1x^3 + 1x^2 + 1x^1";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly =
                "1x^62 + 1x^61 + 1x^60 + 1x^59 + 1x^58 + 1x^57 + 1x^56 + 1x^55 + 1x^54 + 1x^53 + 1x^52 + 1x^51 + 1x^50 "
                "+ 1x^49 + 1x^48 + 1x^47 + 1x^46 + 1x^45 + 1x^44 + 1x^43 + 1x^42 + 1x^41 + 1x^40 + 1x^39 + 1x^38 + "
                "1x^37 + 1x^36 + 1x^35 + 1x^34 + 1x^33 + 1x^32 + 1x^31 + 1x^30 + 1x^29 + 1x^28 + 1x^27 + 1x^26 + 1x^25 "
                "+ 1x^24 + 1x^23 + 1x^22 + 1x^21 + 1x^20 + 1x^19 + 1x^18 + 1x^17 + 1x^16 + 1x^15 + 1x^14 + 1x^13 + "
                "1x^12 + 1x^11 + 1x^10 + 1x^9 + 1x^8 + 1x^7 + 1x^6 + 1x^5 + 1x^4 + 1x^3 + 1x^2 + 1x^1 + 1";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly =
                "1x^28 + 1x^25 + 1x^23 + 1x^21 + 1x^20 + 1x^19 + 1x^16 + 1x^15 + 1x^13 + 1x^12 + 1x^7 + 1x^5 + 1";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());
        }
        {
            parms.setPolyModulusDegree(256);
            parms.setCoeffModulus(CoeffModulus::Create(256, { 40, 40, 40 }));

            SEALContext context(parms, false, SecurityLevel::none);
            KeyGenerator keygen(context);
            PublicKey pk;
            keygen.createPublicKey(pk);

            Encryptor encryptor(context, pk);
            Decryptor decryptor(context, keygen.secretKey());

            Ciphertext encrypted;
            Plaintext plain;
            string hex_poly;
            stringstream stream;

            hex_poly =
                "1x^28 + 1x^25 + 1x^23 + 1x^21 + 1x^20 + 1x^19 + 1x^16 + 1x^15 + 1x^13 + 1x^12 + 1x^7 + 1x^5 + 1";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            // hex_poly =
            //     "1x^28 + 1x^25 + 1x^23 + 1x^21 + 1x^20 + 1x^19 + 1x^16 + 1x^15 + 1x^13 + 1x^12 + 1x^7 + 1x^5 + 1";
            // encryptor.encrypt(Plaintext(hex_poly)).save(stream);
            // encrypted.load(context, stream);
            // decryptor.decrypt(encrypted, plain);
            // ASSERT_EQ(hex_poly, plain.to_string());
            // ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());
        }
        {
            parms.setPolyModulusDegree(256);
            parms.setCoeffModulus(CoeffModulus::Create(256, { 40, 40, 40 }));

            SEALContext context(parms, false, SecurityLevel::none);
            KeyGenerator keygen(context);

            Encryptor encryptor(context, keygen.secretKey());
            Decryptor decryptor(context, keygen.secretKey());

            Ciphertext encrypted;
            Plaintext plain;
            string hex_poly;
            stringstream stream;

            hex_poly =
                "1x^28 + 1x^25 + 1x^23 + 1x^21 + 1x^20 + 1x^19 + 1x^16 + 1x^15 + 1x^13 + 1x^12 + 1x^7 + 1x^5 + 1";
            encryptor.encryptSymmetric(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            // hex_poly =
            //     "1x^28 + 1x^25 + 1x^23 + 1x^21 + 1x^20 + 1x^19 + 1x^16 + 1x^15 + 1x^13 + 1x^12 + 1x^7 + 1x^5 + 1";
            // encryptor.encryptSymmetric(Plaintext(hex_poly)).save(stream);
            // encrypted.load(context, stream);
            // decryptor.decrypt(encrypted, plain);
            // ASSERT_EQ(hex_poly, plain.to_string());
            // ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());
        }
    }

    TEST(EncryptorTest, BFVEncryptZeroDecrypt)
    {
        EncryptionParameters parms(SchemeType::bfv);
        Modulus plain_modulus(1 << 6);
        parms.setPlainModulus(plain_modulus);
        parms.setPolyModulusDegree(64);
        parms.setCoeffModulus(CoeffModulus::Create(64, { 40, 40, 40 }));
        SEALContext context(parms, true, SecurityLevel::none);
        KeyGenerator keygen(context);
        PublicKey pk;
        keygen.createPublicKey(pk);

        Encryptor encryptor(context, pk, keygen.secretKey());
        Decryptor decryptor(context, keygen.secretKey());

        Ciphertext ct;
        Plaintext pt;
        ParmsID next_parms = context.firstContextData()->nextContextData()->parmsID();
        {
            encryptor.encryptZero(ct);
            ASSERT_FALSE(ct.isNttForm());
            ASSERT_FALSE(ct.isTransparent());
            ASSERT_DOUBLE_EQ(ct.scale(), 1.0);
            ASSERT_EQ(ct.correctionFactor(), uint64_t(1));
            decryptor.decrypt(ct, pt);
            ASSERT_TRUE(pt.isZero());

            encryptor.encryptZero(next_parms, ct);
            ASSERT_FALSE(ct.isNttForm());
            ASSERT_FALSE(ct.isTransparent());
            ASSERT_DOUBLE_EQ(ct.scale(), 1.0);
            ASSERT_EQ(ct.correctionFactor(), uint64_t(1));
            ASSERT_EQ(ct.parmsID(), next_parms);
            decryptor.decrypt(ct, pt);
            ASSERT_TRUE(pt.isZero());
        }
        {
            // stringstream stream;
            // encryptor.encryptZero().save(stream);
            // ct.load(context, stream);
            // ASSERT_FALSE(ct.isNttForm());
            // ASSERT_FALSE(ct.isTransparent());
            // ASSERT_DOUBLE_EQ(ct.scale(), 1.0);
            // ASSERT_EQ(ct.correctionFactor(), uint64_t(1));
            // decryptor.decrypt(ct, pt);
            // ASSERT_TRUE(pt.isZero());

            // encryptor.encryptZero(next_parms).save(stream);
            // ct.load(context, stream);
            // ASSERT_FALSE(ct.isNttForm());
            // ASSERT_FALSE(ct.isTransparent());
            // ASSERT_DOUBLE_EQ(ct.scale(), 1.0);
            // ASSERT_EQ(ct.correctionFactor(), uint64_t(1));
            // ASSERT_EQ(ct.parmsID(), next_parms);
            // decryptor.decrypt(ct, pt);
            // ASSERT_TRUE(pt.isZero());
        }
        {
            encryptor.encryptZeroSymmetric(ct);
            ASSERT_FALSE(ct.isNttForm());
            ASSERT_FALSE(ct.isTransparent());
            ASSERT_DOUBLE_EQ(ct.scale(), 1.0);
            ASSERT_EQ(ct.correctionFactor(), uint64_t(1));
            decryptor.decrypt(ct, pt);
            ASSERT_TRUE(pt.isZero());

            encryptor.encryptZeroSymmetric(next_parms, ct);
            ASSERT_FALSE(ct.isNttForm());
            ASSERT_FALSE(ct.isTransparent());
            ASSERT_DOUBLE_EQ(ct.scale(), 1.0);
            ASSERT_EQ(ct.correctionFactor(), uint64_t(1));
            ASSERT_EQ(ct.parmsID(), next_parms);
            decryptor.decrypt(ct, pt);
            ASSERT_TRUE(pt.isZero());
        }
        {
            // stringstream stream;
            // encryptor.encryptZeroSymmetric().save(stream);
            // ct.load(context, stream);
            // ASSERT_FALSE(ct.isNttForm());
            // ASSERT_FALSE(ct.isTransparent());
            // ASSERT_DOUBLE_EQ(ct.scale(), 1.0);
            // ASSERT_EQ(ct.correctionFactor(), uint64_t(1));
            // decryptor.decrypt(ct, pt);
            // ASSERT_TRUE(pt.isZero());

            // encryptor.encryptZeroSymmetric(next_parms).save(stream);
            // ct.load(context, stream);
            // ASSERT_FALSE(ct.isNttForm());
            // ASSERT_FALSE(ct.isTransparent());
            // ASSERT_DOUBLE_EQ(ct.scale(), 1.0);
            // ASSERT_EQ(ct.correctionFactor(), uint64_t(1));
            // ASSERT_EQ(ct.parmsID(), next_parms);
            // decryptor.decrypt(ct, pt);
            // ASSERT_TRUE(pt.isZero());
        }
    }

    TEST(EncryptorTest, CKKSEncryptZeroDecrypt)
    {
        EncryptionParameters parms(SchemeType::ckks);
        parms.setPolyModulusDegree(64);
        parms.setCoeffModulus(CoeffModulus::Create(64, { 40, 40, 40 }));

        SEALContext context(parms, true, SecurityLevel::none);
        KeyGenerator keygen(context);
        PublicKey pk;
        keygen.createPublicKey(pk);

        Encryptor encryptor(context, pk, keygen.secretKey());
        Decryptor decryptor(context, keygen.secretKey());
        CKKSEncoder encoder(context);

        Ciphertext ct;
        Plaintext pt;
        vector<complex<double>> res;
        ParmsID next_parms = context.firstContextData()->nextContextData()->parmsID();
        {
            encryptor.encryptZero(ct);
            ASSERT_FALSE(ct.isTransparent());
            ASSERT_TRUE(ct.isNttForm());
            ASSERT_DOUBLE_EQ(ct.scale(), 1.0);
            ASSERT_EQ(ct.correctionFactor(), uint64_t(1));
            ct.scale() = pow(2.0, 20);
            decryptor.decrypt(ct, pt);
            encoder.decode(pt, res);
            for (auto val : res)
            {
                ASSERT_NEAR(val.real(), 0.0, 0.01);
                ASSERT_NEAR(val.imag(), 0.0, 0.01);
            }

            encryptor.encryptZero(next_parms, ct);
            ASSERT_FALSE(ct.isTransparent());
            ASSERT_TRUE(ct.isNttForm());
            ASSERT_DOUBLE_EQ(ct.scale(), 1.0);
            ASSERT_EQ(ct.correctionFactor(), uint64_t(1));
            ct.scale() = pow(2.0, 20);
            ASSERT_EQ(ct.parmsID(), next_parms);
            decryptor.decrypt(ct, pt);
            ASSERT_EQ(pt.parmsID(), next_parms);
            encoder.decode(pt, res);
            for (auto val : res)
            {
                ASSERT_NEAR(val.real(), 0.0, 0.01);
                ASSERT_NEAR(val.imag(), 0.0, 0.01);
            }
        }
        {
            // stringstream stream;
            // encryptor.encryptZero().save(stream);
            // ct.load(context, stream);
            // ASSERT_FALSE(ct.isTransparent());
            // ASSERT_TRUE(ct.isNttForm());
            // ASSERT_DOUBLE_EQ(ct.scale(), 1.0);
            // ASSERT_EQ(ct.correctionFactor(), uint64_t(1));
            // ct.scale() = pow(2.0, 20);
            // decryptor.decrypt(ct, pt);
            // encoder.decode(pt, res);
            // for (auto val : res)
            // {
            //     ASSERT_NEAR(val.real(), 0.0, 0.01);
            //     ASSERT_NEAR(val.imag(), 0.0, 0.01);
            // }

            // encryptor.encryptZero(next_parms).save(stream);
            // ct.load(context, stream);
            // ASSERT_FALSE(ct.isTransparent());
            // ASSERT_TRUE(ct.isNttForm());
            // ASSERT_DOUBLE_EQ(ct.scale(), 1.0);
            // ASSERT_EQ(ct.correctionFactor(), uint64_t(1));
            // ct.scale() = pow(2.0, 20);
            // ASSERT_EQ(ct.parmsID(), next_parms);
            // decryptor.decrypt(ct, pt);
            // ASSERT_EQ(pt.parmsID(), next_parms);
            // encoder.decode(pt, res);
            // for (auto val : res)
            // {
            //     ASSERT_NEAR(val.real(), 0.0, 0.01);
            //     ASSERT_NEAR(val.imag(), 0.0, 0.01);
            // }
        }
        {
            encryptor.encryptZeroSymmetric(ct);
            ASSERT_FALSE(ct.isTransparent());
            ASSERT_TRUE(ct.isNttForm());
            ASSERT_DOUBLE_EQ(ct.scale(), 1.0);
            ASSERT_EQ(ct.correctionFactor(), uint64_t(1));
            ct.scale() = pow(2.0, 20);
            decryptor.decrypt(ct, pt);
            encoder.decode(pt, res);
            for (auto val : res)
            {
                ASSERT_NEAR(val.real(), 0.0, 0.01);
                ASSERT_NEAR(val.imag(), 0.0, 0.01);
            }

            encryptor.encryptZeroSymmetric(next_parms, ct);
            ASSERT_FALSE(ct.isTransparent());
            ASSERT_TRUE(ct.isNttForm());
            ASSERT_DOUBLE_EQ(ct.scale(), 1.0);
            ASSERT_EQ(ct.correctionFactor(), uint64_t(1));
            ct.scale() = pow(2.0, 20);
            ASSERT_EQ(ct.parmsID(), next_parms);
            decryptor.decrypt(ct, pt);
            ASSERT_EQ(pt.parmsID(), next_parms);
            encoder.decode(pt, res);
            for (auto val : res)
            {
                ASSERT_NEAR(val.real(), 0.0, 0.01);
                ASSERT_NEAR(val.imag(), 0.0, 0.01);
            }
        }
        {
            // stringstream stream;
            // encryptor.encryptZeroSymmetric().save(stream);
            // ct.load(context, stream);
            // ASSERT_FALSE(ct.isTransparent());
            // ASSERT_TRUE(ct.isNttForm());
            // ASSERT_DOUBLE_EQ(ct.scale(), 1.0);
            // ASSERT_EQ(ct.correctionFactor(), uint64_t(1));
            // ct.scale() = pow(2.0, 20);
            // decryptor.decrypt(ct, pt);
            // encoder.decode(pt, res);
            // for (auto val : res)
            // {
            //     ASSERT_NEAR(val.real(), 0.0, 0.01);
            //     ASSERT_NEAR(val.imag(), 0.0, 0.01);
            // }

            // encryptor.encryptZeroSymmetric(next_parms).save(stream);
            // ct.load(context, stream);
            // ASSERT_FALSE(ct.isTransparent());
            // ASSERT_TRUE(ct.isNttForm());
            // ASSERT_DOUBLE_EQ(ct.scale(), 1.0);
            // ASSERT_EQ(ct.correctionFactor(), uint64_t(1));
            // ct.scale() = pow(2.0, 20);
            // ASSERT_EQ(ct.parmsID(), next_parms);
            // decryptor.decrypt(ct, pt);
            // ASSERT_EQ(pt.parmsID(), next_parms);
            // encoder.decode(pt, res);
            // for (auto val : res)
            // {
            //     ASSERT_NEAR(val.real(), 0.0, 0.01);
            //     ASSERT_NEAR(val.imag(), 0.0, 0.01);
            // }
        }
    }

    TEST(EncryptorTest, CKKSEncryptDecrypt)
    {
        EncryptionParameters parms(SchemeType::ckks);
        {
            // input consists of ones
            size_t slot_size = 32;
            parms.setPolyModulusDegree(2 * slot_size);
            parms.setCoeffModulus(CoeffModulus::Create(2 * slot_size, { 40, 40, 40, 40 }));

            SEALContext context(parms, true, SecurityLevel::none);
            KeyGenerator keygen(context);
            PublicKey pk;
            keygen.createPublicKey(pk);

            CKKSEncoder encoder(context);
            Encryptor encryptor(context, pk);
            Decryptor decryptor(context, keygen.secretKey());

            Ciphertext encrypted;
            Plaintext plain;
            Plaintext plainRes;

            vector<complex<double>> input(slot_size, 1.0);
            vector<complex<double>> output(slot_size);
            const double delta = static_cast<double>(1 << 16);

            encoder.encode(input, context.firstParmsID(), delta, plain);
            encryptor.encrypt(plain, encrypted);

            // check correctness of encryption
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            decryptor.decrypt(encrypted, plainRes);
            encoder.decode(plainRes, output);

            for (size_t i = 0; i < slot_size; i++)
            {
                auto tmp = abs(input[i].real() - output[i].real());
                ASSERT_TRUE(tmp < 0.5);
            }
        }
        {
            // input consists of zeros
            size_t slot_size = 32;
            parms.setPolyModulusDegree(2 * slot_size);
            parms.setCoeffModulus(CoeffModulus::Create(2 * slot_size, { 40, 40, 40, 40 }));

            SEALContext context(parms, false, SecurityLevel::none);
            KeyGenerator keygen(context);
            PublicKey pk;
            keygen.createPublicKey(pk);

            CKKSEncoder encoder(context);
            Encryptor encryptor(context, pk);
            Decryptor decryptor(context, keygen.secretKey());

            Ciphertext encrypted;
            Plaintext plain;
            Plaintext plainRes;

            vector<complex<double>> input(slot_size, 0.0);
            vector<complex<double>> output(slot_size);
            const double delta = static_cast<double>(1 << 16);

            encoder.encode(input, context.firstParmsID(), delta, plain);
            encryptor.encrypt(plain, encrypted);

            // check correctness of encryption
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            decryptor.decrypt(encrypted, plainRes);
            encoder.decode(plainRes, output);

            for (size_t i = 0; i < slot_size; i++)
            {
                auto tmp = abs(input[i].real() - output[i].real());
                ASSERT_TRUE(tmp < 0.5);
            }
        }
        {
            // Input is a random mix of positive and negative integers
            size_t slot_size = 64;
            parms.setPolyModulusDegree(2 * slot_size);
            parms.setCoeffModulus(CoeffModulus::Create(2 * slot_size, { 60, 60, 60 }));

            SEALContext context(parms, false, SecurityLevel::none);
            KeyGenerator keygen(context);
            PublicKey pk;
            keygen.createPublicKey(pk);

            CKKSEncoder encoder(context);
            Encryptor encryptor(context, pk);
            Decryptor decryptor(context, keygen.secretKey());

            Ciphertext encrypted;
            Plaintext plain;
            Plaintext plainRes;

            vector<complex<double>> input(slot_size);
            vector<complex<double>> output(slot_size);

            srand(static_cast<unsigned>(time(NULL)));
            int input_bound = 1 << 30;
            const double delta = static_cast<double>(1ULL << 50);

            for (int round = 0; round < 100; round++)
            {
                for (size_t i = 0; i < slot_size; i++)
                {
                    input[i] = pow(-1.0, rand() % 2) * static_cast<double>(rand() % input_bound);
                }

                encoder.encode(input, context.firstParmsID(), delta, plain);
                encryptor.encrypt(plain, encrypted);

                // check correctness of encryption
                ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

                decryptor.decrypt(encrypted, plainRes);
                encoder.decode(plainRes, output);

                for (size_t i = 0; i < slot_size; i++)
                {
                    auto tmp = abs(input[i].real() - output[i].real());
                    ASSERT_TRUE(tmp < 0.5);
                }
            }
        }
        {
            // Input is a random mix of positive and negative integers
            size_t slot_size = 32;
            parms.setPolyModulusDegree(128);
            parms.setCoeffModulus(CoeffModulus::Create(128, { 60, 60, 60 }));

            SEALContext context(parms, false, SecurityLevel::none);
            KeyGenerator keygen(context);
            PublicKey pk;
            keygen.createPublicKey(pk);

            CKKSEncoder encoder(context);
            Encryptor encryptor(context, pk);
            Decryptor decryptor(context, keygen.secretKey());

            Ciphertext encrypted;
            Plaintext plain;
            Plaintext plainRes;

            vector<complex<double>> input(slot_size);
            vector<complex<double>> output(slot_size);

            srand(static_cast<unsigned>(time(NULL)));
            int input_bound = 1 << 30;
            const double delta = static_cast<double>(1ULL << 60);

            for (int round = 0; round < 100; round++)
            {
                for (size_t i = 0; i < slot_size; i++)
                {
                    input[i] = pow(-1.0, rand() % 2) * static_cast<double>(rand() % input_bound);
                }

                encoder.encode(input, context.firstParmsID(), delta, plain);
                encryptor.encrypt(plain, encrypted);

                // check correctness of encryption
                ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

                decryptor.decrypt(encrypted, plainRes);
                encoder.decode(plain, output);

                for (size_t i = 0; i < slot_size; i++)
                {
                    auto tmp = abs(input[i].real() - output[i].real());
                    ASSERT_TRUE(tmp < 0.5);
                }
            }
        }
        {
            // Encrypt at lower level
            size_t slot_size = 32;
            parms.setPolyModulusDegree(2 * slot_size);
            parms.setCoeffModulus(CoeffModulus::Create(2 * slot_size, { 40, 40, 40, 40 }));

            SEALContext context(parms, true, SecurityLevel::none);
            KeyGenerator keygen(context);
            PublicKey pk;
            keygen.createPublicKey(pk);

            CKKSEncoder encoder(context);
            Encryptor encryptor(context, pk);
            Decryptor decryptor(context, keygen.secretKey());

            Ciphertext encrypted;
            Plaintext plain;
            Plaintext plainRes;

            vector<complex<double>> input(slot_size, 1.0);
            vector<complex<double>> output(slot_size);
            const double delta = static_cast<double>(1 << 16);

            auto first_context_data = context.firstContextData();
            ASSERT_NE(nullptr, first_context_data.get());
            auto second_context_data = first_context_data->nextContextData();
            ASSERT_NE(nullptr, second_context_data.get());
            auto second_parms_id = second_context_data->parmsID();

            encoder.encode(input, second_parms_id, delta, plain);
            encryptor.encrypt(plain, encrypted);

            // Check correctness of encryption
            ASSERT_TRUE(encrypted.parmsID() == second_parms_id);

            decryptor.decrypt(encrypted, plainRes);
            encoder.decode(plainRes, output);

            for (size_t i = 0; i < slot_size; i++)
            {
                auto tmp = abs(input[i].real() - output[i].real());
                ASSERT_TRUE(tmp < 0.5);
            }

            // stringstream stream;
            // encoder.encode(input, second_parms_id, delta, plain);
            // encryptor.encrypt(plain).save(stream);
            // encrypted.load(context, stream);
            // // Check correctness of encryption
            // ASSERT_TRUE(encrypted.parmsID() == second_parms_id);
            // decryptor.decrypt(encrypted, plainRes);
            // encoder.decode(plainRes, output);
            // for (size_t i = 0; i < slot_size; i++)
            // {
            //     auto tmp = abs(input[i].real() - output[i].real());
            //     ASSERT_TRUE(tmp < 0.5);
            // }
        }
        {
            // Encrypt at lower level
            size_t slot_size = 32;
            parms.setPolyModulusDegree(2 * slot_size);
            parms.setCoeffModulus(CoeffModulus::Create(2 * slot_size, { 40, 40, 40, 40 }));

            SEALContext context(parms, true, SecurityLevel::none);
            KeyGenerator keygen(context);

            CKKSEncoder encoder(context);
            Encryptor encryptor(context, keygen.secretKey());
            Decryptor decryptor(context, keygen.secretKey());

            Ciphertext encrypted;
            Plaintext plain;
            Plaintext plainRes;
            stringstream stream;

            vector<complex<double>> input(slot_size, 1.0);
            vector<complex<double>> output(slot_size);
            const double delta = static_cast<double>(1 << 16);

            auto first_context_data = context.firstContextData();
            ASSERT_NE(nullptr, first_context_data.get());
            auto second_context_data = first_context_data->nextContextData();
            ASSERT_NE(nullptr, second_context_data.get());
            auto second_parms_id = second_context_data->parmsID();

            encoder.encode(input, second_parms_id, delta, plain);
            encryptor.encryptSymmetric(plain, encrypted);
            // Check correctness of encryption
            ASSERT_TRUE(encrypted.parmsID() == second_parms_id);
            decryptor.decrypt(encrypted, plainRes);
            encoder.decode(plainRes, output);
            for (size_t i = 0; i < slot_size; i++)
            {
                auto tmp = abs(input[i].real() - output[i].real());
                ASSERT_TRUE(tmp < 0.5);
            }

            // encoder.encode(input, second_parms_id, delta, plain);
            // encryptor.encryptSymmetric(plain).save(stream);
            // encrypted.load(context, stream);
            // // Check correctness of encryption
            // ASSERT_TRUE(encrypted.parmsID() == second_parms_id);
            // decryptor.decrypt(encrypted, plainRes);
            // encoder.decode(plainRes, output);
            // for (size_t i = 0; i < slot_size; i++)
            // {
            //     auto tmp = abs(input[i].real() - output[i].real());
            //     ASSERT_TRUE(tmp < 0.5);
            // }
        }
    }

    TEST(EncryptorTest, BGVEncryptDecrypt)
    {
        EncryptionParameters parms(SchemeType::bgv);
        Modulus plain_modulus(1 << 6);
        parms.setPlainModulus(plain_modulus);
        {
            parms.setPolyModulusDegree(64);
            parms.setCoeffModulus(CoeffModulus::Create(64, { 60, 60, 60 }));
            SEALContext context(parms, false, SecurityLevel::none);
            KeyGenerator keygen(context);
            PublicKey pk;
            keygen.createPublicKey(pk);

            Encryptor encryptor(context, pk);
            Decryptor decryptor(context, keygen.secretKey());

            Ciphertext encrypted;
            Plaintext plain;
            string hex_poly;

            hex_poly =
                "1x^28 + 1x^25 + 1x^21 + 1x^20 + 1x^18 + 1x^14 + 1x^12 + 1x^10 + 1x^9 + 1x^6 + 1x^5 + 1x^4 + 1x^3";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly = "0";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly = "1";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly = "1x^1";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly =
                "1x^62 + 1x^61 + 1x^60 + 1x^59 + 1x^58 + 1x^57 + 1x^56 + 1x^55 + 1x^54 + 1x^53 + 1x^52 + 1x^51 + 1x^50 "
                "+ 1x^49 + 1x^48 + 1x^47 + 1x^46 + 1x^45 + 1x^44 + 1x^43 + 1x^42 + 1x^41 + 1x^40 + 1x^39 + 1x^38 + "
                "1x^37 + 1x^36 + 1x^35 + 1x^34 + 1x^33 + 1x^32 + 1x^31 + 1x^30 + 1x^29 + 1x^28 + 1x^27 + 1x^26 + 1x^25 "
                "+ 1x^24 + 1x^23 + 1x^22 + 1x^21 + 1x^20 + 1x^19 + 1x^18 + 1x^17 + 1x^16 + 1x^15 + 1x^14 + 1x^13 + "
                "1x^12 + 1x^11 + 1x^10 + 1x^9 + 1x^8 + 1x^7 + 1x^6 + 1x^5 + 1x^4 + 1x^3 + 1x^2 + 1";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly =
                "1x^62 + 1x^61 + 1x^60 + 1x^59 + 1x^58 + 1x^57 + 1x^56 + 1x^55 + 1x^54 + 1x^53 + 1x^52 + 1x^51 + 1x^50 "
                "+ 1x^49 + 1x^48 + 1x^47 + 1x^46 + 1x^45 + 1x^44 + 1x^43 + 1x^42 + 1x^41 + 1x^40 + 1x^39 + 1x^38 + "
                "1x^37 + 1x^36 + 1x^35 + 1x^34 + 1x^33 + 1x^32 + 1x^31 + 1x^30 + 1x^29 + 1x^28 + 1x^27 + 1x^26 + 1x^25 "
                "+ 1x^24 + 1x^23 + 1x^22 + 1x^21 + 1x^20 + 1x^19 + 1x^18 + 1x^17 + 1x^16 + 1x^15 + 1x^14 + 1x^13 + "
                "1x^12 + 1x^11 + 1x^10 + 1x^9 + 1x^8 + 1x^7 + 1x^6 + 1x^5 + 1x^4 + 1x^3 + 1x^2 + 1x^1";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly =
                "3Fx^62 + 1x^61 + 1x^60 + 1x^59 + 1x^58 + 1x^57 + 1x^56 + 1x^55 + 1x^54 + 1x^53 + 1x^52 + 1x^51 + "
                "1x^50 "
                "+ 1x^49 + 1x^48 + 1x^47 + 1x^46 + 1x^45 + 1x^44 + 1x^43 + 1x^42 + 1x^41 + 1x^40 + 1x^39 + 1x^38 + "
                "1x^37 + 1x^36 + 1x^35 + 1x^34 + 1x^33 + 1x^32 + 1x^31 + 1x^30 + 1x^29 + 1x^28 + 1x^27 + 1x^26 + 1x^25 "
                "+ 1x^24 + 1x^23 + 1x^22 + 1x^21 + 1x^20 + 1x^19 + 1x^18 + 1x^17 + 1x^16 + 1x^15 + 1x^14 + 1x^13 + "
                "1x^12 + 1x^11 + 1x^10 + 1x^9 + 1x^8 + 1x^7 + 1x^6 + 1x^5 + 1x^4 + 1x^3 + 1x^2 + 1x^1 + 1";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());

            hex_poly =
                "1x^28 + 1x^25 + 1x^23 + 1x^21 + 1x^20 + 1x^19 + 1x^16 + 1x^15 + 1x^13 + 1x^12 + 1x^7 + 1x^5 + 1";
            encryptor.encrypt(Plaintext(hex_poly), encrypted);
            decryptor.decrypt(encrypted, plain);
            ASSERT_EQ(hex_poly, plain.to_string());
            ASSERT_TRUE(encrypted.parmsID() == context.firstParmsID());
        }
    }

    TEST(EncryptorTest, BGVEncryptZeroDecrypt)
    {
        EncryptionParameters parms(SchemeType::bgv);
        Modulus plain_modulus(1 << 6);
        parms.setPlainModulus(plain_modulus);
        parms.setPolyModulusDegree(64);
        parms.setCoeffModulus(CoeffModulus::Create(64, { 60, 60, 60 }));
        SEALContext context(parms, true, SecurityLevel::none);
        KeyGenerator keygen(context);
        PublicKey pk;
        keygen.createPublicKey(pk);

        Encryptor encryptor(context, pk, keygen.secretKey());
        Decryptor decryptor(context, keygen.secretKey());

        Ciphertext ct;
        Plaintext pt;
        ParmsID next_parms = context.firstContextData()->nextContextData()->parmsID();
        {
            encryptor.encryptZero(ct);
            ASSERT_FALSE(ct.isNttForm());
            ASSERT_FALSE(ct.isTransparent());
            ASSERT_DOUBLE_EQ(ct.scale(), 1.0);
            ASSERT_EQ(ct.correctionFactor(), uint64_t(1));
            decryptor.decrypt(ct, pt);
            ASSERT_TRUE(pt.isZero());

            encryptor.encryptZero(next_parms, ct);
            ASSERT_FALSE(ct.isNttForm());
            ASSERT_FALSE(ct.isTransparent());
            ASSERT_DOUBLE_EQ(ct.scale(), 1.0);
            ASSERT_EQ(ct.correctionFactor(), uint64_t(1));
            ASSERT_EQ(ct.parmsID(), next_parms);
            decryptor.decrypt(ct, pt);
            ASSERT_TRUE(pt.isZero());
        }
        {
            // stringstream stream;
            // encryptor.encryptZero().save(stream);
            // ct.load(context, stream);
            // ASSERT_FALSE(ct.isNttForm());
            // ASSERT_FALSE(ct.isTransparent());
            // ASSERT_DOUBLE_EQ(ct.scale(), 1.0);
            // ASSERT_EQ(ct.correctionFactor(), uint64_t(1));
            // decryptor.decrypt(ct, pt);
            // ASSERT_TRUE(pt.isZero());

            // encryptor.encryptZero(next_parms).save(stream);
            // ct.load(context, stream);
            // ASSERT_FALSE(ct.isNttForm());
            // ASSERT_FALSE(ct.isTransparent());
            // ASSERT_DOUBLE_EQ(ct.scale(), 1.0);
            // ASSERT_EQ(ct.correctionFactor(), uint64_t(1));
            // ASSERT_EQ(ct.parmsID(), next_parms);
            // decryptor.decrypt(ct, pt);
            // ASSERT_TRUE(pt.isZero());
        }
        {
            encryptor.encryptZeroSymmetric(ct);
            ASSERT_FALSE(ct.isNttForm());
            ASSERT_FALSE(ct.isTransparent());
            ASSERT_DOUBLE_EQ(ct.scale(), 1.0);
            ASSERT_EQ(ct.correctionFactor(), uint64_t(1));
            decryptor.decrypt(ct, pt);
            ASSERT_TRUE(pt.isZero());

            encryptor.encryptZeroSymmetric(next_parms, ct);
            ASSERT_FALSE(ct.isNttForm());
            ASSERT_FALSE(ct.isTransparent());
            ASSERT_DOUBLE_EQ(ct.scale(), 1.0);
            ASSERT_EQ(ct.correctionFactor(), uint64_t(1));
            ASSERT_EQ(ct.parmsID(), next_parms);
            decryptor.decrypt(ct, pt);
            ASSERT_TRUE(pt.isZero());
        }
        {
            // stringstream stream;
            // encryptor.encryptZeroSymmetric().save(stream);
            // ct.load(context, stream);
            // ASSERT_FALSE(ct.isNttForm());
            // ASSERT_FALSE(ct.isTransparent());
            // ASSERT_DOUBLE_EQ(ct.scale(), 1.0);
            // ASSERT_EQ(ct.correctionFactor(), uint64_t(1));
            // decryptor.decrypt(ct, pt);
            // ASSERT_TRUE(pt.isZero());

            // encryptor.encryptZeroSymmetric(next_parms).save(stream);
            // ct.load(context, stream);
            // ASSERT_FALSE(ct.isNttForm());
            // ASSERT_FALSE(ct.isTransparent());
            // ASSERT_DOUBLE_EQ(ct.scale(), 1.0);
            // ASSERT_EQ(ct.correctionFactor(), uint64_t(1));
            // ASSERT_EQ(ct.parmsID(), next_parms);
            // decryptor.decrypt(ct, pt);
            // ASSERT_TRUE(pt.isZero());
        }
    }
} // namespace sealtest


*/